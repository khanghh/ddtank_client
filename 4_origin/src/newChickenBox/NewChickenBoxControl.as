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
         var i:int = 0;
         var j:int = 0;
         var pkg:PackageIn = NewChickenBoxManager.instance.pkgs["init"];
         if(pkg == null)
         {
            return;
         }
         _model.canOpenCounts = pkg.readInt();
         _model.openCardPrice = [];
         for(i = 0; i < _model.canOpenCounts; )
         {
            _model.openCardPrice.push(pkg.readInt());
            i++;
         }
         _model.canEagleEyeCounts = pkg.readInt();
         _model.eagleEyePrice = [];
         for(j = 0; j < _model.canEagleEyeCounts; )
         {
            _model.eagleEyePrice.push(pkg.readInt());
            j++;
         }
         _model.flushPrice = pkg.readInt();
         _model.endTime = pkg.readDate();
         NewChickenBoxManager.instance.pkgs["init"] = null;
         addSocketEvent();
      }
      
      private function getItem() : void
      {
         var i:int = 0;
         var iteminfo:* = null;
         var pkg:PackageIn = NewChickenBoxManager.instance.pkgs["getItem"];
         if(pkg == null)
         {
            return;
         }
         _model.countTime = 0;
         _model.countEye = 0;
         _model.lastFlushTime = pkg.readDate();
         _model.freeFlushTime = pkg.readInt();
         _model.freeRefreshBoxCount = pkg.readInt();
         _model.freeEyeCount = pkg.readInt();
         _model.freeOpenCardCount = pkg.readInt();
         _model.isShowAll = pkg.readBoolean();
         _model.boxCount = pkg.readInt();
         for(i = 0; i < _model.boxCount; )
         {
            iteminfo = new NewChickenBoxGoodsTempInfo();
            iteminfo.TemplateID = pkg.readInt();
            iteminfo.info = ItemManager.Instance.getTemplateById(iteminfo.TemplateID);
            iteminfo.StrengthenLevel = pkg.readInt();
            iteminfo.Count = pkg.readInt();
            iteminfo.ValidDate = pkg.readInt();
            iteminfo.AttackCompose = pkg.readInt();
            iteminfo.DefendCompose = pkg.readInt();
            iteminfo.AgilityCompose = pkg.readInt();
            iteminfo.LuckCompose = pkg.readInt();
            iteminfo.Position = pkg.readInt();
            iteminfo.IsSelected = pkg.readBoolean();
            iteminfo.IsSeeded = pkg.readBoolean();
            iteminfo.IsBinds = pkg.readBoolean();
            if(iteminfo.IsSelected)
            {
               _model.countTime++;
            }
            if(iteminfo.IsSeeded)
            {
               _model.countEye++;
            }
            if(_model.isShowAll)
            {
               if(firstEnter)
               {
                  if(_model.templateIDList.length == 18)
                  {
                     _model.templateIDList[i] = iteminfo;
                  }
                  else
                  {
                     _model.templateIDList.push(iteminfo);
                  }
                  _model.countTime = 0;
                  _model.countEye = 0;
                  trace("点击图标第一次进入",_model.templateIDList.length);
               }
               else if(_model.templateIDList.length == 18)
               {
                  _model.templateIDList[i] = iteminfo;
               }
               _model.canclickEnable = false;
            }
            else
            {
               if(_model.templateIDList.length == 18)
               {
                  _model.templateIDList[i] = iteminfo;
               }
               else
               {
                  _model.templateIDList.push(iteminfo);
               }
               _model.canclickEnable = true;
            }
            i++;
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
      
      private function __overshow(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         timer = new Timer(50,1);
         timer.addEventListener("timerComplete",sendOverShow);
         timer.start();
         var timer1:Timer = new Timer(5000,1);
         timer1.addEventListener("timerComplete",sendAgain);
         timer1.start();
         if(newChickenBoxFrame)
         {
            newChickenBoxFrame.closeButton.enable = false;
            newChickenBoxFrame.escEnable = false;
            newChickenBoxFrame.flushBnt.enable = false;
         }
      }
      
      private function sendAgain(e:TimerEvent) : void
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
      
      private function sendOverShow(e:TimerEvent) : void
      {
         var times:int = 0;
         SocketManager.Instance.out.sendOverShowItems();
         _model.countTime = 0;
         _model.countEye = 0;
         if(newChickenBoxFrame)
         {
            newChickenBoxFrame.startBnt.enable = false;
            newChickenBoxFrame.eyeBtn.enable = false;
            newChickenBoxFrame.openCardBtn.enable = false;
            times = _model.canOpenCounts + 1 - _model.countTime;
            newChickenBoxFrame.countNum.setFrame(times);
         }
         timer.removeEventListener("timerComplete",sendOverShow);
         timer = null;
      }
      
      private function __canclick(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _model.canclickEnable = pkg.readBoolean();
         _model.dispatchEvent(new NewChickenBoxEvents("canclickenable"));
      }
      
      private function __showBoxFrameHandler(event:Event) : void
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
      
      private function __openCard(e:PkgEvent) : void
      {
         var bg:* = null;
         var pkg:PackageIn = e.pkg;
         var iteminfo:NewChickenBoxGoodsTempInfo = new NewChickenBoxGoodsTempInfo();
         iteminfo.TemplateID = pkg.readInt();
         iteminfo.info = ItemManager.Instance.getTemplateById(iteminfo.TemplateID);
         iteminfo.StrengthenLevel = pkg.readInt();
         iteminfo.Count = pkg.readInt();
         iteminfo.ValidDate = pkg.readInt();
         iteminfo.AttackCompose = pkg.readInt();
         iteminfo.DefendCompose = pkg.readInt();
         iteminfo.AgilityCompose = pkg.readInt();
         iteminfo.LuckCompose = pkg.readInt();
         iteminfo.Position = pkg.readInt();
         iteminfo.IsSelected = pkg.readBoolean();
         iteminfo.IsSeeded = pkg.readBoolean();
         iteminfo.IsBinds = pkg.readBoolean();
         _model.freeOpenCardCount = pkg.readInt();
         var s:Sprite = new Sprite();
         s.graphics.beginFill(16777215,0);
         s.graphics.drawRect(0,0,39,39);
         s.graphics.endFill();
         var cell:NewChickenBoxCell = new NewChickenBoxCell(s,iteminfo.info);
         if(iteminfo.IsSelected)
         {
            bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenOver") as MovieClip;
         }
         else if(iteminfo.IsSeeded)
         {
            bg = ClassUtils.CreatInstance("asset.newChickenBox.chicken360") as MovieClip;
         }
         var item:NewChickenBoxItem = new NewChickenBoxItem(cell,bg);
         item.info = iteminfo;
         item.position = iteminfo.Position;
         newChickenBoxFrame.newBoxView.removeChild(_model.itemList[iteminfo.Position]);
         _model.itemList[iteminfo.Position] = item;
         newChickenBoxFrame.newBoxView.addChild(_model.itemList[iteminfo.Position]);
         _model.itemList[iteminfo.Position].bg = bg;
         _model.itemList[iteminfo.Position].cell = cell;
         _model.itemList[iteminfo.Position].cell.visible = false;
         var p:String = "newChickenBox.itemPos" + iteminfo.Position;
         PositionUtils.setPos(_model.itemList[iteminfo.Position],p);
         _model.countTime++;
         var times:int = _model.canOpenCounts + 1 - _model.countTime;
         newChickenBoxFrame.countNum.setFrame(times);
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
      
      private function __openEye(e:PkgEvent) : void
      {
         var bg:* = null;
         var pkg:PackageIn = e.pkg;
         var iteminfo:NewChickenBoxGoodsTempInfo = new NewChickenBoxGoodsTempInfo();
         iteminfo.TemplateID = pkg.readInt();
         iteminfo.info = ItemManager.Instance.getTemplateById(iteminfo.TemplateID);
         iteminfo.StrengthenLevel = pkg.readInt();
         iteminfo.Count = pkg.readInt();
         iteminfo.ValidDate = pkg.readInt();
         iteminfo.AttackCompose = pkg.readInt();
         iteminfo.DefendCompose = pkg.readInt();
         iteminfo.AgilityCompose = pkg.readInt();
         iteminfo.LuckCompose = pkg.readInt();
         iteminfo.Position = pkg.readInt();
         iteminfo.IsSelected = pkg.readBoolean();
         iteminfo.IsSeeded = pkg.readBoolean();
         iteminfo.IsBinds = pkg.readBoolean();
         _model.freeEyeCount = pkg.readInt();
         var s:Sprite = new Sprite();
         s.graphics.beginFill(16777215,0);
         s.graphics.drawRect(0,0,39,39);
         s.graphics.endFill();
         var cell:NewChickenBoxCell = new NewChickenBoxCell(s,iteminfo.info);
         if(iteminfo.IsSelected)
         {
            bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenOver") as MovieClip;
         }
         else if(iteminfo.IsSeeded)
         {
            bg = ClassUtils.CreatInstance("asset.newChickenBox.chicken360") as MovieClip;
         }
         _model.countEye++;
         var item:NewChickenBoxItem = new NewChickenBoxItem(cell,bg);
         item.info = iteminfo;
         item.position = iteminfo.Position;
         newChickenBoxFrame.newBoxView.removeChild(_model.itemList[iteminfo.Position]);
         _model.itemList[iteminfo.Position] = item;
         newChickenBoxFrame.newBoxView.addChild(_model.itemList[iteminfo.Position]);
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
         _model.itemList[iteminfo.Position].bg = bg;
         _model.itemList[iteminfo.Position].cell = cell;
         _model.itemList[iteminfo.Position].cell.visible = false;
         var p:String = "newChickenBox.itemPos" + iteminfo.Position;
         PositionUtils.setPos(_model.itemList[iteminfo.Position],p);
         newChickenBoxFrame.newBoxView.getItemEvent(item);
      }
      
      private function __closeActivityHandler(event:Event) : void
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
