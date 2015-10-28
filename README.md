# TaiwanRadioN
TaiwanRadioN 是 [TaiwanRadio][1] 未上架版本.

為什麼不上架? 因為要跟著 HIChannel API 跑, 而且還要經過 Apple 審核, 已經覺得麻煩了.

除非有 Crash, 否則 [TaiwanRadio][1] 應該不會再修改了, 最多透過 [JSPatch][2] 與 [自定義參數][3] 修正即可.


## 差異
TaiwanRadioN 與 [TaiwanRadio][1] 之間的差異性:

### 不使用後台
TaiwanRadioN 不再使用 [LeanCloud][4] 當後台, 而是使用本地端 [RadioList.json][5] 當資料來源.

> RadioList.json 是透過 [HIChannel List API][6] 取得.

### 沒有廣告
TaiwanRadioN 移除了 iAd 與 AdMob 廣告.

### 沒有 3RD Library
TaiwanRadioN 沒使用任何 3rd Library, 所以連 CocoaPods 都移除了.


## 安裝
如果你是 iOS 開發者, 應該不用再贅述.  
如果你不是 iOS 開發者, 你必須有以下條件:

1. 一個 Apple Id.
2. [Xcode][7] 7.0 之後的版本


之後 [下載][10] TaiwanRadioN, 再照著 [教學][8] 便可以把 TaiwanRadioN 安裝至你的 iPhone.


## LICENSE
[MIT LICENSE][9]

[1]: https://github.com/shinrenpan/TaiwanRadio "TaiwanRadio"
[2]: https://github.com/bang590/JSPatch "JSPatch"
[3]: https://github.com/shinrenpan/TaiwanRadio/wiki/後台建置#自定義參數 "自定義參數"
[4]: https://leancloud.cn "LeanCloud"
[5]: TaiwanRadio/RadioList.json "RadioList.json"
[6]: https://hichannel.hinet.net/radio/channelList.do "List"
[7]: https://developer.apple.com/xcode/download/ "xcode"
[8]: http://www.dycksir.com/2015/10/10/Launching-Your-App-on-Devices-Xcode-7-without-certificate/ "教學"
[9]: LICENSE "LICENSE"
[10]: https://github.com/shinrenpan/TaiwanRadioN/archive/master.zip "下載"
