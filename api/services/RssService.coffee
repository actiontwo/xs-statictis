exports.router = 'http://xskt.com.vn/'
exports.provinces = ()->
  data = [
    {name : 'An Giang', slug : 'an-giang', url : '/rss-feed/an-giang-xsag.rss'}
    {name : 'Binh Dương', slug : 'binh-duong', url : '/rss-feed/binh-duong-xsbd.rss'}
    {name : 'Bình Định', slug : 'binh-dinh', url : '/rss-feed/binh-dinh-xsbdi.rss'}
    {name : 'Bạc Liêu', slug : 'bac-lieu', url : '/rss-feed/bac-lieu-xsbl.rss'}
    {name : 'Bình Phước', slug : 'binh-phuoc', url : '/rss-feed/binh-phuoc-xsbp.rss'}
    {name : 'Bến Tre', slug : 'ben-tre', url : '/rss-feed/ben-tre-xsbt.rss'}
    {name : 'Bình Thuận', slug : 'binh-thuan', url : '/rss-feed/binh-thuan-xsbth.rss'}
    {name : 'Ca Mau', slug : 'ca-mau', url : '/rss-feed/ca-mau-xscm.rss'}
    {name : 'Cần Thơ', slug : 'can-tho', url : '/rss-feed/can-tho-xsct.rss'}
    {name : 'Đắc Lắc', slug : 'dac-lac', url : '/rss-feed/dac-lac-xsdlk.rss'}
    {name : 'Đồng Nai', slug : 'dong-nai', url : '/rss-feed/dong-nai-xsdn.rss'}
    {name : 'Đà Nẵng', slug : 'da-nang', url : '/rss-feed/da-nang-xsdng.rss'}
    {name : 'Đắc Nông', slug : 'dac-nong', url : '/rss-feed/dac-nong-xsdno.rss'}
    {name : 'Đồng Tháp', slug : 'dong-thap', url : '/rss-feed/dong-thap-xsdt.rss'}
    {name : 'Gia Lai', slug : 'gia-lai', url : '/rss-feed/gia-lai-xsgl.rss'}
    {name : 'TP Hồ Chí Minh', slug : 'ho-chi-minh', url : '/rss-feed/tp-hcm-xshcm.rss'}
    {name : 'Hậu Giang', slug : 'hau-giang', url : '/rss-feed/hau-giang-xshg.rss'}
    {name : 'Kiên Giang', slug : 'kien-giang', url : '/rss-feed/kien-giang-xskg.rss'}
    {name : 'Khánh Hoà', slug : 'khanh-hoa', url : '/rss-feed/khanh-hoa-xskh.rss'}
    {name : 'Kon Tum', slug : 'kon-tum', url : '/rss-feed/kon-tum-xskt.rss'}
    {name : 'Long An', slug : 'long-an', url : '/rss-feed/long-an-xsla.rss'}
    {name : 'Lâm Đồng', slug : 'lam-dong', url : '/rss-feed/lam-dong-xsld.rss'}
    {name : 'Ninh Thuận', slug : 'ninh-thuan', url : '/rss-feed/ninh-thuan-xsnt.rss'}
    {name : 'Phú Yên', slug : 'phu-yen', url : '/rss-feed/phu-yen-xspy.rss'}
    {name : 'Quảng Bình', slug : 'quang-binh', url : '/rss-feed/quang-binh-xsqb.rss'}
    {name : 'Quảng Ngãi', slug : 'quang-ngai', url : '/rss-feed/quang-ngai-xsqng.rss'}
    {name : 'Quảng Nam', slug : 'quang-nam', url : '/rss-feed/quang-nam-xsqnm.rss'}
    {name : 'Quảng Trị', slug : 'quang-tri', url : '/rss-feed/quang-tri-xsqt.rss'}
    {name : 'Sóc Trăng', slug : 'soc-trang', url : '/rss-feed/soc-trang-xsst.rss'}
    {name : 'Tiền Giang', slug : 'tien-giang', url : '/rss-feed/tien-giang-xstg.rss'}
    {name : 'Tây Ninh', slug : 'tay-ninh', url : '/rss-feed/tay-ninh-xstn.rss'}
    {name : 'Thừa Thiên Huế', slug : 'thua-thien-hue', url : '/rss-feed/thua-thien-hue-xstth.rss'}
    {name : 'Trà Vinh', slug : 'tra-vinh', url : '/rss-feed/tra-vinh-xstv.rss'}
    {name : 'Vĩnh Long', slug : 'vinh-long', url : '/rss-feed/vinh-long-xsvl.rss'}
    {name : 'Vũng Tàu', slug : 'vung-tau', url : '/rss-feed/vung-tau-xsvt.rss'}
  ]
  return data
exports.xmlToJson = (data) ->
  parser = require('xml2json')
  return JSON.parse parser.toJson(data)

exports.formatDate = (data = '30-1-2016')->
  date = data.split(/-/);
  return new Date((new Date("#{date[1]}/#{date[0]}/#{date[2]}")).getTime() + 7 * 3600 * 1000)

exports.formatData = (data, province = 'HCM')->
  data = RssService.xmlToJson data
  path = require 'path'
  info = []
  getDesciption = (item)->
    temp = item.description.split(/[0-9]:\s/)
    _.map temp, (value, key)->
      result =
        date : RssService.formatDate (path.basename item.link, '.html')
        type : key
        province : province

      split = value.split /\s/
      if split[0] is 'ĐB:'
        result.value = split[1].trim()
        return info.push result

      split = value.split /-/
      _.map split, (el)->
        result.value = el.trim()
        info.push result

  _.map data.rss.channel.item, getDesciption

  return info
