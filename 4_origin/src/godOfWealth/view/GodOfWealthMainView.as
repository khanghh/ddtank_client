package godOfWealth.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import godOfWealth.GodOfWealthManager;
   import homeTemple.view.N_BitmapDataNumber;
   import org.aswing.KeyboardManager;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class GodOfWealthMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _btnPay:Scale9CornerImage;
      
      private var _detailTxt:FilterFrameText;
      
      private var _endTimeTxt:FilterFrameText;
      
      private var _endTime:Number;
      
      private var _timer:TimerJuggler;
      
      private var _numRes:N_BitmapDataNumber;
      
      private var _numTxtBitmap:Bitmap;
      
      private var _numTitleBitmap:Bitmap;
      
      public var id:int;
      
      public function GodOfWealthMainView()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creat("ast.godofwealth.bg");
         addChild(_bg);
         _closeBtn = ComponentFactory.Instance.creat("godOfWealth.closeBtn");
         _closeBtn.addEventListener("click",onCloseClick);
         addChild(_closeBtn);
         KeyboardManager.getInstance().addEventListener("keyDown",onKeyDown);
         _btnPay = ComponentFactory.Instance.creat("asset.godOfWealth.btn");
         _btnPay.useHandCursor = true;
         _btnPay.buttonMode = true;
         _btnPay.x = 300 - _btnPay.width * 0.5;
         _btnPay.addEventListener("rollOut",onOut);
         _btnPay.addEventListener("rollOver",onOver);
         _btnPay.addEventListener("mouseDown",onDown);
         _btnPay.addEventListener("click",onPayClick);
         addChild(_btnPay);
         var _loc1_:Vector.<BitmapData> = new Vector.<BitmapData>();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_[_loc2_] = ComponentFactory.Instance.creatBitmapData("ast.godofwealth.n" + _loc2_.toString());
            _loc2_++;
         }
         _numRes = new N_BitmapDataNumber();
         _numRes.gap = -3;
         _numRes.numList = _loc1_;
         _numRes.rect = new Rectangle(0,0,134,24);
         _numTitleBitmap = ComponentFactory.Instance.creatBitmap("ast.godofwealth.txt.buy");
         PositionUtils.setPos(_numTitleBitmap,"godOfWealth.btnTitlePos");
         addChild(_numTitleBitmap);
         _numTxtBitmap = new Bitmap(_numRes.getNumber("0"));
         _numTxtBitmap.x = _numTitleBitmap.x + _numTitleBitmap.width;
         _numTxtBitmap.y = _numTitleBitmap.y + 1;
         addChild(_numTxtBitmap);
         _detailTxt = ComponentFactory.Instance.creat("godOfWealth.detailText");
         addChild(_detailTxt);
         _endTimeTxt = ComponentFactory.Instance.creat("godOfWealth.endTimeText");
         addChild(_endTimeTxt);
         _endTime = GodOfWealthManager.getInstance().endTime();
         _timer = TimerManager.getInstance().addTimer1000ms(1000);
         _timer.addEventListener("timer",onEndTimeTimer);
         _timer.start();
         onEndTimeTimer(null);
      }
      
      protected function onEndTimeTimer(param1:Event) : void
      {
         var _loc2_:Number = _endTime - TimeManager.Instance.Now().time;
         _endTimeTxt.text = Helpers.getTimeString(_loc2_);
         if(_loc2_ <= 0)
         {
            _btnPay.mouseEnabled = false;
            Helpers.grey(_btnPay);
         }
         else
         {
            _btnPay.mouseEnabled = true;
            Helpers.colorful(_btnPay);
         }
      }
      
      protected function onDown(param1:MouseEvent) : void
      {
         _btnPay.y = 435;
         _btnPay.alpha = 1;
      }
      
      protected function onOver(param1:MouseEvent) : void
      {
         _btnPay.y = 434;
         _btnPay.alpha = 0.9;
         _btnPay.filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      protected function onOut(param1:MouseEvent) : void
      {
         _btnPay.y = 435;
         _btnPay.alpha = 1;
         _btnPay.filters = [];
      }
      
      protected function onPayClick(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(GodOfWealthManager.getInstance().nextPayNeeded <= 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("godOfWealth.alert.godIsSmiling");
            MessageTipManager.getInstance().show(_loc3_,0,true,1);
         }
         else
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            KeyboardManager.getInstance().removeEventListener("keyDown",onKeyDown);
            _loc3_ = LanguageMgr.GetTranslation("godOfWealth.alert",GodOfWealthManager.getInstance().nextPayNeeded);
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
            _loc2_.addEventListener("response",onResponse);
         }
      }
      
      protected function onResponse(param1:FrameEvent) : void
      {
         param1.target.removeEventListener("response",onResponse);
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               CheckMoneyUtils.instance.checkMoney(false,GodOfWealthManager.getInstance().nextPayNeeded,onChecked,onCanceled);
            default:
               CheckMoneyUtils.instance.checkMoney(false,GodOfWealthManager.getInstance().nextPayNeeded,onChecked,onCanceled);
         }
         KeyboardManager.getInstance().addEventListener("keyDown",onKeyDown);
      }
      
      private function onCanceled() : void
      {
      }
      
      private function onChecked() : void
      {
         GameInSocketOut.sendGodOfWealthPay();
      }
      
      protected function onKeyDown(param1:KeyboardEvent) : void
      {
         if(!(int(param1.keyCode) - 27))
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      protected function onCloseClick(param1:MouseEvent) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      public function update() : void
      {
         var _loc1_:int = GodOfWealthManager.getInstance().nextPayNeeded;
         if(_loc1_ <= 0)
         {
            _numTitleBitmap.bitmapData = ComponentFactory.Instance.creatBitmapData("ast.godofwealth.txt.tks");
            _numTxtBitmap.visible = false;
            _detailTxt.text = LanguageMgr.GetTranslation("godOfWealth.detail.timesOut");
            _btnPay.width = _numTitleBitmap.width + 9;
            _btnPay.x = 300 - _btnPay.width * 0.5;
            _numTitleBitmap.x = 300 - _numTitleBitmap.width * 0.5;
         }
         else
         {
            _numTitleBitmap.bitmapData = ComponentFactory.Instance.creatBitmapData("ast.godofwealth.txt.buy");
            _numTxtBitmap.bitmapData = _numRes.getNumber(_loc1_.toString());
            _numTxtBitmap.visible = true;
            _detailTxt.text = LanguageMgr.GetTranslation("godOfWealth.detail",GodOfWealthManager.getInstance().nextRewardMin,GodOfWealthManager.getInstance().nextRewardMax);
            _btnPay.width = _numTitleBitmap.width + _loc1_.toString().length * 20 + 12;
            _btnPay.x = 300 - _btnPay.width * 0.5;
            _numTitleBitmap.x = _btnPay.x + 4;
            _numTxtBitmap.x = _numTitleBitmap.x + _numTitleBitmap.width;
         }
         _endTime = GodOfWealthManager.getInstance().endTime();
         onEndTimeTimer(null);
      }
      
      public function dispose() : void
      {
         _timer.stop();
         TimerManager.getInstance().removeTimer1000ms(_timer);
         _timer.removeEventListener("timer",onEndTimeTimer);
         _timer = null;
         _closeBtn.removeEventListener("click",onCloseClick);
         KeyboardManager.getInstance().removeEventListener("keyDown",onKeyDown);
         _btnPay.removeEventListener("rollOut",onOut);
         _btnPay.removeEventListener("rollOver",onOver);
         _btnPay.removeEventListener("mouseDown",onDown);
         _btnPay.removeEventListener("click",onPayClick);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _closeBtn = null;
         _closeBtn = null;
         _detailTxt = null;
         _numRes = null;
         _numTxtBitmap = null;
         _numTitleBitmap = null;
         _endTimeTxt = null;
      }
   }
}
