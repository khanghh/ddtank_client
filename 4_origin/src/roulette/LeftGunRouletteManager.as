package roulette
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class LeftGunRouletteManager extends CoreManager
   {
      
      private static var _instance:LeftGunRouletteManager = null;
      
      private static const TYPE_ROULETTE:int = 1;
      
      private static const TYPEI_ISOPEN:int = 1;
      
      private static const MAX_LENGTH:int = 20;
       
      
      public var reward:String;
      
      public var gCount:int;
      
      private var _alertAward:BaseAlerFrame;
      
      public var IsOpen:Boolean;
      
      public var ArrNum:Array;
      
      public var beginTime:Date;
      
      public var endTime:Date;
      
      public var isFrist:Boolean = false;
      
      public var isvisible:Boolean = true;
      
      private var isShow:Boolean;
      
      private var _content:Sprite;
      
      public function LeftGunRouletteManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : LeftGunRouletteManager
      {
         if(_instance == null)
         {
            _instance = new LeftGunRouletteManager();
         }
         return _instance;
      }
      
      public function init() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(137),__openRoulett);
      }
      
      private function __openRoulett(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:PackageIn = param1.pkg;
         var _loc7_:int = _loc6_.readInt();
         if(!(int(_loc7_) - 1))
         {
            _loc5_ = _loc6_.readInt();
            if(!(int(_loc5_) - 1))
            {
               IsOpen = _loc6_.readBoolean();
               if(IsOpen)
               {
                  isFrist = true;
                  _loc4_ = _loc6_.readInt();
                  _loc2_ = _loc6_.readUTF();
                  dispatchEvent(new RouletteFrameEvent("leftGun_enable"));
                  if(_loc4_ <= 0 && _loc2_ == "0")
                  {
                     reward = _loc2_;
                     isvisible = false;
                     return;
                  }
                  gCount = _loc4_;
                  reward = _loc2_;
                  isvisible = true;
                  ArrNum = [];
                  _loc8_ = 0;
                  while(_loc8_ < 20)
                  {
                     _loc3_ = _loc6_.readInt();
                     ArrNum.push(_loc3_);
                     _loc8_++;
                  }
                  beginTime = _loc6_.readDate();
                  endTime = _loc6_.readDate();
                  showGunButton();
               }
               else
               {
                  hideGunButton();
               }
            }
         }
      }
      
      public function showGunButton() : void
      {
         HallIconManager.instance.updateSwitchHandler("leftGunRoulette",true);
      }
      
      public function hideGunButton() : void
      {
         SoundManager.instance.playMusic("062");
         removeGunBtn();
         dispatchEvent(new CEvent("closeView"));
         if(_alertAward)
         {
            _alertAward.removeEventListener("response",__goRenewal);
            _alertAward.dispose();
            _alertAward = null;
         }
      }
      
      private function removeGunBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("leftGunRoulette",false);
      }
      
      public function showTurnplate() : void
      {
         if(isvisible)
         {
            SoundManager.instance.playMusic("140");
            createFrame(_content);
         }
         else
         {
            showTipFrame(reward);
         }
      }
      
      public function showTipFrame(param1:String) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("tank.roulette.tipInfo",param1);
         _alertAward = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _alertAward.moveEnable = false;
         _alertAward.addEventListener("response",__goRenewal);
      }
      
      private function getReward(param1:String) : String
      {
         var _loc3_:* = null;
         var _loc2_:Array = param1.split(".");
         var _loc6_:int = _loc2_[0];
         var _loc4_:int = _loc2_[1];
         var _loc5_:int = _loc6_ - 1;
         if(_loc5_ == 0)
         {
            _loc3_ = _loc4_ + "0" + "%";
         }
         else
         {
            _loc3_ = _loc5_.toString() + _loc4_.toString() + "0" + "%";
         }
         return _loc3_;
      }
      
      public function createFrame(param1:Sprite = null) : void
      {
         dispatchEvent(new CEvent("openview",param1));
      }
      
      private function __goRenewal(param1:FrameEvent) : void
      {
         if(_alertAward)
         {
            _alertAward.removeEventListener("response",__goRenewal);
         }
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               LeavePageManager.leaveToFillPath();
               break;
            case 2:
         }
         _alertAward.dispose();
         if(_alertAward.parent)
         {
            _alertAward.parent.removeChild(_alertAward);
         }
         _alertAward = null;
      }
   }
}
