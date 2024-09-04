use worker::{Request, Response, Env, Context, event, console_log, Method};

#[event(fetch)]
pub async fn main(mut req: Request, _env: Env, _ctx: Context) -> worker::Result<Response> {
    console_log!(
        "{} {}, located at: {:?}, within: {}",
        req.method().to_string(),
        req.path(),
        req.cf().unwrap().coordinates().unwrap_or_default(),
        req.cf().unwrap().region().unwrap_or("unknown region".into())
    );

    if !matches!(req.method(), Method::Post) {
        return Response::error("Method Not Allowed", 405);
    }

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
}


// console_error_panic_hook::set_once();
