// ★★★ 短信模板及数据转换
export function getSMSTemplate (str) {
  let smsTemplate = str; // 短信模板
  let results = smsTemplate.match(/{(.*?)}/g) || [];
  results.forEach((item, index, array) => {
    smsTemplate = smsTemplate.replace(item, `{${index + 1}}`);
  });
  return smsTemplate
}

// ★★★ 短信模板及数据转换
export function getSMSData (str, dataObj) {
  let numKeyObj = {}; // 数字键对象
  let dataOjb = {}; // 数据对象
  let smsTemplate = str; // 短信模板

  let results = smsTemplate.match(/{(.*?)}/g) || [];
  // console.log(results);
  results.forEach((item, index, array) => {
    smsTemplate = smsTemplate.replace(item, `{${index + 1}}`);
    // if(dataOjb)
    numKeyObj[index + 1] = dataObj[item.slice(1, -1).trim()];
    dataOjb[item.slice(1, -1).trim()] = dataObj[item.slice(1, -1).trim()];
  });

  return {
    smsTemplate,
    numKeyObj,
    dataOjb
  };
}
