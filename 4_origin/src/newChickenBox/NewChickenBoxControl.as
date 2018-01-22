package newChickenBox
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import newChickenBox.data.NewChickenBoxGoodsTempInfo;
   import newChickenBox.events.NewChickenBoxEvents;
   import newChickenBox.model.NewChickenBoxModel;
   import newChickenBox.view.NewChickenBoxCell;
   import newChickenBox.view.NewChickenBoxFrame;
   import newChickenBox.view.NewChickenBoxItem;
   import road7th.comm.PackageIn;
   
   public class NewChickenBoxControl extends EventDispatcher
   {
      
      private static var _instance:NewChickenBoxControl = null;
       
      
      private var newChickenBoxFrame:NewChickenBoxFrame;
      
      public var firstEnter:Boolean = true;
      
      private var _model:NewChickenBoxModel;
      
      private var timer:Timer;
      
      public function NewChickenBoxControl()
      {
         super();
         _model = NewChickenBoxModel.instance;
      }
      
      public static function get instance() : NewChickenBoxControl
      {
         if(_instance == null)
         {
            _instance = new NewChickenBoxControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         NewChickenBoxManager.instance.addEventListener("showBoxFrame",__showBoxFrameHandler);
         NewChickenBoxManager.instance.addEventListener("closeActivity",__closeActivityHandler);
      }
      
      private function init() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:PackageIn = NewChickenBoxManager.instance.pkgs["init"];
         if(_loc1_ == null)
         {
            return;
         }
         _model.canOpenCounts = _loc1_.readInt();
         _model.openCardPrice = [];
         _loc3_ = 0;
         while(_loc3_ < _model.canOpenCounts)
         {
            _model.openCardPrice.push(_loc1_.readInt());
            _loc3_++;
         }
         _model.canEagleEyeCounts = _loc1_.readInt();
         _model.eagleEyePrice = [];
         _loc2_ = 0;
         while(_loc2_ < _model.canEagleEyeCounts)
         {
            _model.eagleEyePrice.push(_loc1_.readInt());
            _loc2_++;
         }
         _model.flushPrice = _loc1_.readInt();
         _model.endTime = _loc1_.readDate();
         NewChickenBoxManager.instance.pkgs["init"] = null;
         addSocketEvent();
      }
      
      private function getItem() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:PackageIn = NewChickenBoxManager.instance.pkgs["getItem"];
         if(_loc1_ == null)
         {
            return;
         }
         _model.countTime = 0;
         _model.countEye = 0;
         _model.lastFlushTime = _loc1_.readDate();
         _model.freeFlushTime = _loc1_.readInt();
         _model.freeRefreshBoxCount = _loc1_.readInt();
         _model.freeEyeCount = _loc1_.readInt();
         _model.freeOpenCardCount = _loc1_.readInt();
         _model.isShowAll = _loc1_.readBoolean();
         _model.boxCount = _loc1_.readInt();
         _loc3_ = 0;
         while(_loc3_ < _model.boxCount)
         {
            _loc2_ = new NewChickenBoxGoodsTempInfo();
            _loc2_.TemplateID = _loc1_.readInt();
            _loc2_.info = ItemManager.Instance.getTemplateById(_loc2_.TemplateID);
            _loc2_.StrengthenLevel = _loc1_.readInt();
            _loc2_.Count = _loc1_.readInt();
            _loc2_.ValidDate = _loc1_.readInt();
            _loc2_.AttackCompose = _loc1_.readInt();
            _loc2_.DefendCompose = _loc1_.readInt();
            _loc2_.AgilityCompose = _loc1_.readInt();
            _loc2_.LuckCompose = _loc1_.readInt();
            _loc2_.Position = _loc1_.readInt();
            _loc2_.IsSelected = _loc1_.readBoolean();
            _loc2_.IsSeeded = _loc1_.readBoolean();
            _loc2_.IsBinds = _loc1_.readBoolean();
            if(_loc2_.IsSelected)
            {
               _model.countTime++;
            }
            if(_loc2_.IsSeeded)
            {
               _model.countEye++;
            }
            if(_model.isShowAll)
            {
               if(firstEnter)
               {
                  if(_model.templateIDList.length == 18)
                  {
                     _model.templateIDList[_loc3_] = _loc2_;
                  }
                  else
                  {
                     _model.templateIDList.push(_loc2_);
                  }
                  _model.countTime = 0;
                  _model.countEye = 0;
                  trace("点击图标第一次进入",_model.templateIDList.length);
               }
               else if(_model.templateIDList.length == 18)
               {
                  _model.templateIDList[_loc3_] = _loc2_;
               }
               _model.canclickEnable = false;
            }
            else
            {
               if(_model.templateIDList.length == 18)
               {
                  _model.templateIDList[_loc3_] = _loc2_;
               }
               else
               {
                  _model.templateIDList.push(_loc2_);
               }
               _model.canclickEnable = true;
            }
            _loc3_++;
         }
         NewChickenBoxManager.instance.pkgs["getItem"] = null;
      }
      
      private function addSocketEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(87,5),__canclick);
         SocketManager.Instance.addEventListener(PkgEvent.format(87,4),__openCard);
         SocketManager.Instance.addEventListener(PkgEvent.format(87,7),__openEye);
         SocketManager.Instance.addEventListener(PkgEvent.format(87,6),__overshow);
      }
      
      private function __overshow(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         timer = new Timer(50,1);
         timer.addEventListener("timerComplete",sendOverShow);
         timer.start();
         var _loc2_:Timer = new Timer(5000,1);
         _loc2_.addEventListener("timerComplete",sendAgain);
         _loc2_.start();
         if(newChickenBoxFrame)
         {
            newChickenBoxFrame.closeButton.enable = false;
            newChickenBoxFrame.escEnable = false;
            newChickenBoxFrame.flushBnt.enable = false;
         }
      }
      
      private function sendAgain(param1:TimerEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newChickenBox.newTurnStart"));
         _model.countTime = 0;
         _model.countEye = 0;
         _model.canclickEnable = false;
         if(newChickenBoxFrame)
         {
            newChickenBoxFrame.startBnt.enable = true;
            newChickenBoxFrame.eyeBtn.enable = false;
            newChickenBoxFrame.openCardBtn.enable = false;
            SocketManager.Instance.out.sendNewChickenBox();
            newChickenBoxFrame.closeButton.enable = true;
            newChickenBoxFrame.escEnable = true;
            newChickenBoxFrame.flushBnt.enable = true;
         }
      }
      
      private function sendOverShow(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         SocketManager.Instance.out.sendOverShowItems();
         _model.countTime = 0;
         _model.countEye = 0;
         if(newChickenBoxFrame)
         {
            newChickenBoxFrame.startBnt.enable = false;
            newChickenBoxFrame.eyeBtn.enable = false;
            newChickenBoxFrame.openCardBtn.enable = false;
            _loc2_ = _model.canOpenCounts + 1 - _model.countTime;
            newChickenBoxFrame.countNum.setFrame(_loc2_);
         }
         timer.removeEventListener("timerComplete",sendOverShow);
         timer = null;
      }
      
      private function __canclick(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.canclickEnable = _loc2_.readBoolean();
         _model.dispatchEvent(new NewChickenBoxEvents("canclickenable"));
      }
      
      private function __showBoxFrameHandler(param1:Event) : void
      {
         init();
         getItem();
         if(firstEnter)
         {
            newChickenBoxFrame = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.newChickenBoxFrame");
            if(_model.isShowAll)
            {
               newChickenBoxFrame.startBnt.enable = true;
               newChickenBoxFrame.eyeBtn.enable = false;
               newChickenBoxFrame.openCardBtn.enable = false;
            }
            else
            {
               newChickenBoxFrame.startBnt.enable = false;
               newChickenBoxFrame.eyeBtn.enable = true;
               newChickenBoxFrame.openCardBtn.enable = true;
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newChickenBox.firstEnterHelp"));
            }
            LayerManager.Instance.addToLayer(newChickenBoxFrame,3,true,1);
            newChickenBoxFrame.firstEnterHelp();
            trace("第一次new弹窗");
            firstEnter = false;
            if(_model.countEye < _model.canEagleEyeCounts)
            {
               newChickenBoxFrame.eyeBtn.tipData = LanguageMgr.GetTranslation("newChickenBox.useEyeCost",_model.eagleEyePrice[_model.countEye]);
            }
            else
            {
               newChickenBoxFrame.eyeBtn.enable = false;
            }
         }
         else if(newChickenBoxFrame)
         {
            newChickenBoxFrame.newBoxView.getAllItem();
            _model.canclickEnable = false;
            trace("点击刷新更新物品操作");
            newChickenBoxFrame.firestGetTime();
            newChickenBoxFrame.refreshOpenCardBtnTxt();
            newChickenBoxFrame.refreshEagleEyeBtnTxt();
         }
      }
      
      private function __openCard(param1:PkgEvent) : void
      {
         var _loc7_:* = null;
         var _loc8_:PackageIn = param1.pkg;
         var _loc9_:NewChickenBoxGoodsTempInfo = new NewChickenBoxGoodsTempInfo();
         _loc9_.TemplateID = _loc8_.readInt();
         _loc9_.info = ItemManager.Instance.getTemplateById(_loc9_.TemplateID);
         _loc9_.StrengthenLevel = _loc8_.readInt();
         _loc9_.Count = _loc8_.readInt();
         _loc9_.ValidDate = _loc8_.readInt();
         _loc9_.AttackCompose = _loc8_.readInt();
         _loc9_.DefendCompose = _loc8_.readInt();
         _loc9_.AgilityCompose = _loc8_.readInt();
         _loc9_.LuckCompose = _loc8_.readInt();
         _loc9_.Position = _loc8_.readInt();
         _loc9_.IsSelected = _loc8_.readBoolean();
         _loc9_.IsSeeded = _loc8_.readBoolean();
         _loc9_.IsBinds = _loc8_.readBoolean();
         _model.freeOpenCardCount = _loc8_.readInt();
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16777215,0);
         _loc2_.graphics.drawRect(0,0,39,39);
         _loc2_.graphics.endFill();
         var _loc6_:NewChickenBoxCell = new NewChickenBoxCell(_loc2_,_loc9_.info);
         if(_loc9_.IsSelected)
         {
            _loc7_ = ClassUtils.CreatInstance("asset.newChickenBox.chickenOver") as MovieClip;
         }
         else if(_loc9_.IsSeeded)
         {
            _loc7_ = ClassUtils.CreatInstance("asset.newChickenBox.chicken360") as MovieClip;
         }
         var _loc5_:NewChickenBoxItem = new NewChickenBoxItem(_loc6_,_loc7_);
         _loc5_.info = _loc9_;
         _loc5_.position = _loc9_.Position;
         newChickenBoxFrame.newBoxView.removeChild(_model.itemList[_loc9_.Position]);
         _model.itemList[_loc9_.Position] = _loc5_;
         newChickenBoxFrame.newBoxView.addChild(_model.itemList[_loc9_.Position]);
         _model.itemList[_loc9_.Position].bg = _loc7_;
         _model.itemList[_loc9_.Position].cell = _loc6_;
         _model.itemList[_loc9_.Position].cell.visible = false;
         var _loc4_:String = "newChickenBox.itemPos" + _loc9_.Position;
         PositionUtils.setPos(_model.itemList[_loc9_.Position],_loc4_);
         _model.countTime++;
         var _loc3_:int = _model.canOpenCounts + 1 - _model.countTime;
         newChickenBoxFrame.countNum.setFrame(_loc3_);
         if(_model.countTime >= _model.canOpenCounts)
         {
            newChickenBoxFrame.msgText.text = LanguageMgr.GetTranslation("newChickenBox.useMoneyMsg",0);
         }
         else
         {
            newChickenBoxFrame.msgText.text = LanguageMgr.GetTranslation("newChickenBox.useMoneyMsg",_model.openCardPrice[_model.countTime]);
         }
         newChickenBoxFrame.refreshOpenCardBtnTxt();
      }
      
      private function __openEye(param1:PkgEvent) : void
      {
         var _loc6_:* = null;
         var _loc7_:PackageIn = param1.pkg;
         var _loc8_:NewChickenBoxGoodsTempInfo = new NewChickenBoxGoodsTempInfo();
         _loc8_.TemplateID = _loc7_.readInt();
         _loc8_.info = ItemManager.Instance.getTemplateById(_loc8_.TemplateID);
         _loc8_.StrengthenLevel = _loc7_.readInt();
         _loc8_.Count = _loc7_.readInt();
         _loc8_.ValidDate = _loc7_.readInt();
         _loc8_.AttackCompose = _loc7_.readInt();
         _loc8_.DefendCompose = _loc7_.readInt();
         _loc8_.AgilityCompose = _loc7_.readInt();
         _loc8_.LuckCompose = _loc7_.readInt();
         _loc8_.Position = _loc7_.readInt();
         _loc8_.IsSelected = _loc7_.readBoolean();
         _loc8_.IsSeeded = _loc7_.readBoolean();
         _loc8_.IsBinds = _loc7_.readBoolean();
         _model.freeEyeCount = _loc7_.readInt();
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16777215,0);
         _loc2_.graphics.drawRect(0,0,39,39);
         _loc2_.graphics.endFill();
         var _loc5_:NewChickenBoxCell = new NewChickenBoxCell(_loc2_,_loc8_.info);
         if(_loc8_.IsSelected)
         {
            _loc6_ = ClassUtils.CreatInstance("asset.newChickenBox.chickenOver") as MovieClip;
         }
         else if(_loc8_.IsSeeded)
         {
            _loc6_ = ClassUtils.CreatInstance("asset.newChickenBox.chicken360") as MovieClip;
         }
         _model.countEye++;
         var _loc4_:NewChickenBoxItem = new NewChickenBoxItem(_loc5_,_loc6_);
         _loc4_.info = _loc8_;
         _loc4_.position = _loc8_.Position;
         newChickenBoxFrame.newBoxView.removeChild(_model.itemList[_loc8_.Position]);
         _model.itemList[_loc8_.Position] = _loc4_;
         newChickenBoxFrame.newBoxView.addChild(_model.itemList[_loc8_.Position]);
         newChickenBoxFrame.refreshEagleEyeBtnTxt();
         if(_model.countEye < _model.canEagleEyeCounts)
         {
            newChickenBoxFrame.eyeBtn.tipData = LanguageMgr.GetTranslation("newChickenBox.useEyeCost",_model.eagleEyePrice[_model.countEye]);
         }
         else
         {
            newChickenBoxFrame.eyeBtn.enable = false;
            newChickenBoxFrame.setEyeLight(false);
            newChickenBoxFrame.setOpenCardLight(true);
            _model.clickEagleEye = false;
         }
         _model.itemList[_loc8_.Position].bg = _loc6_;
         _model.itemList[_loc8_.Position].cell = _loc5_;
         _model.itemList[_loc8_.Position].cell.visible = false;
         var _loc3_:String = "newChickenBox.itemPos" + _loc8_.Position;
         PositionUtils.setPos(_model.itemList[_loc8_.Position],_loc3_);
         newChickenBoxFrame.newBoxView.getItemEvent(_loc4_);
      }
      
      private function __closeActivityHandler(param1:Event) : void
      {
         _model.canclickEnable = false;
         firstEnter = true;
         if(newChickenBoxFrame)
         {
            newChickenBoxFrame.dispose();
            newChickenBoxFrame = null;
         }
         removeSocketEvent();
      }
      
      private function removeSocketEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(87,5),__canclick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(87,4),__openCard);
         SocketManager.Instance.removeEventListener(PkgEvent.format(87,7),__openEye);
         SocketManager.Instance.removeEventListener(PkgEvent.format(87,6),__overshow);
      }
      
      public function get model() : NewChickenBoxModel
      {
         return _model;
      }
   }
}
