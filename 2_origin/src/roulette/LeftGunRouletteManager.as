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
      
      public function LeftGunRouletteManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      private function __openRoulett(event:PkgEvent) : void
      {
         var typeI:int = 0;
         var count:int = 0;
         var result:* = null;
         var i:int = 0;
         var num:int = 0;
         var pkg:PackageIn = event.pkg;
         var type:int = pkg.readInt();
         if(!(int(type) - 1))
         {
            typeI = pkg.readInt();
            if(!(int(typeI) - 1))
            {
               IsOpen = pkg.readBoolean();
               if(IsOpen)
               {
                  isFrist = true;
                  count = pkg.readInt();
                  result = pkg.readUTF();
                  dispatchEvent(new RouletteFrameEvent("leftGun_enable"));
                  if(count <= 0 && result == "0")
                  {
                     reward = result;
                     isvisible = false;
                     return;
                  }
                  gCount = count;
                  reward = result;
                  isvisible = true;
                  ArrNum = [];
                  for(i = 0; i < 20; )
                  {
                     num = pkg.readInt();
                     ArrNum.push(num);
                     i++;
                  }
                  beginTime = pkg.readDate();
                  endTime = pkg.readDate();
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
      
      public function showTipFrame(reward:String) : void
      {
         var msg:String = LanguageMgr.GetTranslation("tank.roulette.tipInfo",reward);
         _alertAward = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _alertAward.moveEnable = false;
         _alertAward.addEventListener("response",__goRenewal);
      }
      
      private function getReward(str:String) : String
      {
         var reward:* = null;
         var num:Array = str.split(".");
         var num1:int = num[0];
         var num2:int = num[1];
         var num3:int = num1 - 1;
         if(num3 == 0)
         {
            reward = num2 + "0" + "%";
         }
         else
         {
            reward = num3.toString() + num2.toString() + "0" + "%";
         }
         return reward;
      }
      
      public function createFrame(p:Sprite = null) : void
      {
         dispatchEvent(new CEvent("openview",p));
      }
      
      private function __goRenewal(evt:FrameEvent) : void
      {
         if(_alertAward)
         {
            _alertAward.removeEventListener("response",__goRenewal);
         }
         switch(int(evt.responseCode) - 2)
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
