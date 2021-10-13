export function getDomain() {
  const find = function(str, symbol, num) {
    var x = str.indexOf(symbol);
    for (var i = 0; i < num; ++i) {
      x = str.indexOf(symbol, ++x)
    }
    return x
  }
  const url = window.location.href;
  const i = find(url, ':', 1);
  let domain = url.substr(0, i);
  // domain = process.env.NODE_ENV === 'development' ? "http://121.196.101.73:8888" : "http://127.0.0.1:8888";
  // domain = "http://121.196.101.73:8888/api/private/v1"
  domain = "http://127.0.0.1:3000/admin/api"
  return domain
}
