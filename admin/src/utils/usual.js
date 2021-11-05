export function getDomain() {
  const find = (str, cha, num) => {
    let x = str.indexOf(cha);
    for (var i = 0; i < num; i++) {
      x = str.indexOf(cha, x + 1);
    }
    return x;
  };
  const url = window.location.href;
  const i = find(url, ":", 1);
  let domain = url.substring(0, i);
  console.log(domain);
  domain = domain === "http://localhost" ? domain : "http://121.196.101.73";
  domain = domain + ":9000/admin/";
  return domain;
}
