use worker::{Request, Response, Router, Env, Context, event, console_log};

#[event(fetch)]
pub async fn main(mut req: Request, _env: Env, _ctx: Context) -> worker::Result<Response> {
    console_log!(
        "{} {}, located at: {:?}, within: {}",
        req.method().to_string(),
        req.path(),
        req.cf().unwrap().coordinates().unwrap_or_default(),
        req.cf().unwrap().region().unwrap_or("unknown region".into())
    );

    // Create an instance of the Router.
    let router = Router::new();

    // Handle sum calculation.
    router
        .post_async("/", |mut req, _ctx| async move {
            let result: worker::Result<Vec<i32>> = req.json().await;

            match result {
                Ok(numbers) => {
                    let sum: i32 = numbers.iter().sum();
                    Response::ok(sum.to_string())
                },
                Err(e) => {
                    Response::error(&format!("Error occurred while parsing JSON: {:?}", e), 400)
                }
            }
        })
        .run(req, _env).await
}


// console_error_panic_hook::set_once();
