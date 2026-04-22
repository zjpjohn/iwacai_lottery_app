#设置字符编码，防止中文乱码
chcp 65001
@echo off
::设置当前应用版本::
set version=1.0.0
:: 应用打包apk所在文件夹::
set source=D:\cloud-lottery\iwacai_lottery_app\build\app\outputs\apk\release
:: 拷贝APP文件到指定目录::
set target=D:\cloud-lottery\iwacai_sport_apk\
:: 应用打包渠道集合::
set channel=main,baidu,vivo,oppo,huawei,xiaomi
:: 应用环境::
set profile=release
:: 创建拷贝文件夹::
md "%target%%version%"
echo *****************************************
echo         应用打包环境:[%profile%]
echo *****************************************
echo 开始进行应用打包...
for %%a in (%channel%) do (
  echo *****************************************
  echo         应用打包渠道:[%%a]
  echo *****************************************
  call fvm flutter build apk --release --dart-define=APP_PROFILE=%profile% --dart-define=APP_CHANNEL=%%a --no-tree-shake-icons --split-per-abi
  move "%source%\iwacai-sport-v%version%-%%a-arm64-v8a-release.apk" "%target%%version%"
  move "%source%\iwacai-sport-v%version%-%%a-armeabi-v7a-release.apk" "%target%%version%"
  move "%source%\iwacai-sport-v%version%-%%a-universal-release.apk" "%target%%version%"
)
echo 应用打包完成
pause

