package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BuffTip extends BaseTip
   {
       
      
      protected var _tempData:Object;
      
      protected var _bg:ScaleBitmapImage;
      
      protected var lefttime_txt:Bitmap;
      
      protected var name_txt:FilterFrameText;
      
      protected var describe_txt:FilterFrameText;
      
      protected var days_txt:Bitmap;
      
      protected var day_txt:FilterFrameText;
      
      protected var hours_txt:Bitmap;
      
      protected var hour_txt:FilterFrameText;
      
      protected var mins_txt:Bitmap;
      
      protected var min_txt:FilterFrameText;
      
      protected var _activeSp:Sprite;
      
      protected var _timegap:int;
      
      protected var _active:Boolean;
      
      protected var _free:Boolean;
      
      public function BuffTip()
      {
         super();
      }
      
      protected function drawNameField() : void
      {
         name_txt = ComponentFactory.Instance.creat("core.TNameTxt");
         _activeSp.addChild(name_txt);
      }
      
      override protected function init() : void
      {
         _activeSp = new Sprite();
         _bg = ComponentFactory.Instance.creat("asset.core.tip.buffTipBg");
         describe_txt = ComponentFactory.Instance.creat("core.DesTxt");
         drawNameField();
         lefttime_txt = ComponentFactory.Instance.creat("asset.core.bufftip.LTime");
         days_txt = ComponentFactory.Instance.creat("asset.core.bufftip.Day");
         day_txt = ComponentFactory.Instance.creat("core.CommonTxt");
         hours_txt = ComponentFactory.Instance.creat("asset.core.bufftip.Hour");
         hour_txt = ComponentFactory.Instance.creat("core.CommonTxt");
         mins_txt = ComponentFactory.Instance.creat("asset.core.bufftip.Min");
         min_txt = ComponentFactory.Instance.creat("core.CommonTxt");
         _activeSp.addChild(days_txt);
         _activeSp.addChild(day_txt);
         _activeSp.addChild(hours_txt);
         _activeSp.addChild(hour_txt);
         _activeSp.addChild(mins_txt);
         _activeSp.addChild(min_txt);
         _activeSp.addChild(lefttime_txt);
         _activeSp.mouseEnabled = false;
         _activeSp.mouseChildren = false;
         describe_txt.mouseEnabled = false;
         describe_txt.multiline = true;
         describe_txt.wordWrap = true;
         describe_txt.width = 170;
         _timegap = 3;
         super.init();
         this.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(describe_txt);
         describe_txt.mouseEnabled = false;
         addChild(_activeSp);
         _activeSp.mouseEnabled = false;
         _activeSp.mouseChildren = false;
      }
      
      override public function set tipData(data:Object) : void
      {
         _tempData = data;
         if(data is BuffTipInfo)
         {
            this.visible = true;
            setShow(data.isActive,data.isFree,data.day,data.hour,data.min,data.describe);
         }
         else
         {
            this.visible = false;
         }
      }
      
      override public function get tipData() : Object
      {
         return _tempData;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(name_txt);
         name_txt = null;
         ObjectUtils.disposeObject(days_txt);
         days_txt = null;
         ObjectUtils.disposeObject(day_txt);
         day_txt = null;
         ObjectUtils.disposeObject(hours_txt);
         hours_txt = null;
         ObjectUtils.disposeObject(hour_txt);
         hour_txt = null;
         ObjectUtils.disposeObject(mins_txt);
         mins_txt = null;
         ObjectUtils.disposeObject(min_txt);
         min_txt = null;
         if(lefttime_txt)
         {
            ObjectUtils.disposeObject(lefttime_txt);
         }
         lefttime_txt = null;
         if(_activeSp)
         {
            ObjectUtils.disposeObject(_activeSp);
         }
         _activeSp = null;
         ObjectUtils.disposeObject(describe_txt);
         describe_txt = null;
         super.dispose();
      }
      
      protected function setShow(isActive:Boolean, isFree:Boolean, day:int, hour:int, min:int, describe:String) : void
      {
         _active = isActive;
         if(isActive)
         {
            _activeSp.visible = true;
            describe_txt.visible = false;
            if(isFree)
            {
               showFree(true);
               name_txt.text = LanguageMgr.GetTranslation("tank.view.buffControl.buffButton.freeCard");
               day_txt.text = LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.forever");
               day_txt.x = lefttime_txt.x + lefttime_txt.width + _timegap * 2;
            }
            else
            {
               showFree(false);
               name_txt.text = _tempData.name;
               day_txt.text = String(day);
               hour_txt.text = String(hour);
               min_txt.text = String(min);
               day_txt.x = lefttime_txt.x + lefttime_txt.width + _timegap;
               days_txt.x = day_txt.x + day_txt.width + _timegap;
               hour_txt.x = days_txt.x + days_txt.width + _timegap;
               hours_txt.x = hour_txt.x + hour_txt.width + _timegap;
               min_txt.x = hours_txt.x + hours_txt.width + _timegap;
               mins_txt.x = min_txt.x + min_txt.width + _timegap;
            }
         }
         else
         {
            describe_txt.text = describe;
            _activeSp.visible = false;
            describe_txt.visible = true;
         }
         updateWH();
      }
      
      protected function updateWH() : void
      {
         var wid1:int = 0;
         var wid2:int = 0;
         if(_tempData.isActive)
         {
            if(_tempData.isFree)
            {
               wid1 = Math.abs(name_txt.x) * 2 + name_txt.width;
               wid2 = day_txt.x + day_txt.width + name_txt.x;
               _bg.width = wid1 > wid2?wid1:int(wid2);
            }
            else
            {
               _bg.width = int(min_txt.x + min_txt.width + mins_txt.width + 4);
            }
            _bg.height = _activeSp.height + Math.abs(name_txt.y) * 2;
         }
         else
         {
            _bg.width = Math.abs(describe_txt.x) * 2 + describe_txt.width;
            _bg.height = Math.abs(describe_txt.y) * 2 + describe_txt.height;
         }
         _width = _bg.width;
         _height = _bg.height;
      }
      
      private function showFree(bol:Boolean) : void
      {
         days_txt.visible = !bol;
         hours_txt.visible = !bol;
         hour_txt.visible = !bol;
         mins_txt.visible = !bol;
         min_txt.visible = !bol;
      }
   }
}
