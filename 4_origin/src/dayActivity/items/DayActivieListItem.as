package dayActivity.items
{
   import catchbeast.CatchBeastManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import dayActivity.DayActiveData;
   import dayActivity.DayActivityControl;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import entertainmentMode.EntertainmentModeManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import horseRace.controller.HorseRaceManager;
   import lanternriddles.LanternRiddlesManager;
   import rescue.RescueManager;
   import sevenDouble.SevenDoubleManager;
   import trainer.controller.WeakGuildManager;
   import worldBossHelper.WorldBossHelperController;
   
   public class DayActivieListItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:MovieClip;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _txt3:FilterFrameText;
      
      private var _txt4:FilterFrameText;
      
      private var _txt5:FilterFrameText;
      
      private var _worldBossHelperBtn:SimpleBitmapButton;
      
      private var _data:DayActiveData;
      
      private var _index:int;
      
      public var id:int;
      
      private var clickSp:Sprite;
      
      private var _lastCreatTime:int = 0;
      
      public var seleLigthFun:Function;
      
      private var _selectLight:Bitmap;
      
      public var activityTypeID:int;
      
      private var _levelLimit:int;
      
      public function DayActivieListItem(number:int)
      {
         super();
         _index = number;
         clickSp = new Sprite();
         clickSp.useHandCursor = true;
         clickSp.buttonMode = true;
         clickSp.graphics.beginFill(16777215);
         clickSp.graphics.drawRect(0,0,80,20);
         clickSp.graphics.endFill();
         clickSp.alpha = 0;
         useHandCursor = true;
         buttonMode = true;
         addEventListener("click",mouseClickHander);
      }
      
      protected function mouseClickHander(event:MouseEvent) : void
      {
         if(seleLigthFun != null)
         {
            seleLigthFun(this,_data.LevelLimit);
         }
      }
      
      public function get data() : DayActiveData
      {
         return _data;
      }
      
      public function setData(data:DayActiveData) : void
      {
         _data = data;
         id = int(_data.JumpType);
         _levelLimit = int(_data.LevelLimit);
         activityTypeID = _data.ActivityTypeID;
         init(_index);
      }
      
      public function initTxt(bool:Boolean) : void
      {
         ObjectUtils.disposeObject(_txt1);
         ObjectUtils.disposeObject(_txt2);
         ObjectUtils.disposeObject(_txt3);
         ObjectUtils.disposeObject(_txt4);
         ObjectUtils.disposeObject(_txt5);
         if(_worldBossHelperBtn)
         {
            _worldBossHelperBtn.removeEventListener("click",__worldBossHelperHandler);
         }
         ObjectUtils.disposeObject(_worldBossHelperBtn);
         _txt1 = null;
         _txt2 = null;
         _txt3 = null;
         _txt4 = null;
         _txt5 = null;
         _worldBossHelperBtn = null;
         if(bool)
         {
            _txt5 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.closetxt");
            _txt5.text = LanguageMgr.GetTranslation("ddt.dayActivity.close");
            _txt1 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.ctxt1");
            _txt2 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.ctxt2");
            _txt2.wordWrap = true;
            _txt2.multiline = true;
            _txt2.width = 150;
            _txt3 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.ctxt3");
            _txt4 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.ctxt4");
            clickSp.mouseEnabled = false;
         }
         else
         {
            _txt1 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.txt1");
            _txt2 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.txt2");
            _txt2.wordWrap = true;
            _txt2.multiline = true;
            _txt2.width = 150;
            _txt3 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.txt3");
            _txt4 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.txt4");
            _txt5 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.opentxt");
            _txt5.text = LanguageMgr.GetTranslation("ddt.dayActivity.open");
            _txt5.mouseEnabled = false;
            clickSp.useHandCursor = true;
            clickSp.buttonMode = true;
            clickSp.mouseEnabled = true;
            clickSp.addEventListener("click",clickHander);
         }
         _txt1.autoSize = "center";
         _txt1.text = _data.ActiveName;
         _txt1.x = 3;
         _txt1.y = _txt1.numLines > 1?1:11;
         addChild(_txt1);
         var str:String = _data.ActiveTime.substr(0,11) + "\n" + _data.ActiveTime.substr(11,12);
         if(str.length < 15)
         {
            _txt2.y = 9;
            _txt2.height = 25;
         }
         else
         {
            _txt2.y = 1;
            _txt2.height = 40;
            _txt2.wordWrap = true;
            _txt2.multiline = true;
         }
         _txt2.x = 113;
         _txt2.text = str;
         addChild(_txt2);
         _txt3.x = 279;
         _txt3.y = 11;
         if(_data.Count == 0)
         {
            _txt3.text = LanguageMgr.GetTranslation("ddt.dayActivity.notlimited");
         }
         else
         {
            if(_data.TotalCount >= _data.Count)
            {
               _data.TotalCount = _data.Count;
            }
            _txt3.text = _data.TotalCount + "/" + _data.Count;
         }
         addChild(_txt3);
         _txt4.text = _data.Description;
         _txt4.x = 369;
         _txt4.y = _txt4.numLines > 1?3:11;
         addChild(_txt4);
         if(int(_data.JumpType) == 4 || int(_data.JumpType) == 11)
         {
            _worldBossHelperBtn = ComponentFactory.Instance.creatComponentByStylename("day.activity.worldBossHelper.helperBtn");
            _worldBossHelperBtn.buttonMode = true;
            _worldBossHelperBtn.useHandCursor = true;
            _worldBossHelperBtn.x = 490;
            _worldBossHelperBtn.y = 4;
            _worldBossHelperBtn.addEventListener("click",__worldBossHelperHandler);
            addChild(_worldBossHelperBtn);
         }
         _txt5.x = 590;
         _txt5.y = 11;
         clickSp.x = 590;
         clickSp.y = 11;
         addChild(_txt5);
         addChild(clickSp);
      }
      
      private function __worldBossHelperHandler(e:MouseEvent) : void
      {
         if(!WeakGuildManager.Instance.checkOpen(76,20))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",20));
            return;
         }
         SoundManager.instance.playButtonSound();
         WorldBossHelperController.Instance.show();
      }
      
      public function upDataOpenState(bool:Boolean) : void
      {
         clickSp.removeEventListener("click",clickHander);
         ObjectUtils.disposeObject(_txt5);
         if(bool)
         {
            _txt5 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.closetxt");
            _txt5.text = LanguageMgr.GetTranslation("ddt.dayActivity.close");
         }
         else
         {
            _txt5 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.item.opentxt");
            _txt5.text = LanguageMgr.GetTranslation("ddt.dayActivity.open");
         }
         _txt5.x = 618;
         _txt5.y = 6;
         _txt5.mouseEnabled = false;
         clickSp.addEventListener("click",clickHander);
         addChild(_txt5);
         addChild(clickSp);
      }
      
      public function updataCount(num:int) : void
      {
         if(_data.Count == 0)
         {
            _txt3.text = LanguageMgr.GetTranslation("ddt.dayActivity.notlimited");
         }
         else
         {
            if(num >= _data.Count)
            {
               num = _data.Count;
            }
            _txt3.text = num + "/" + _data.Count;
         }
      }
      
      public function getTxt5str() : String
      {
         return _txt5.text;
      }
      
      private function clickHander(event:MouseEvent) : void
      {
         var self:* = null;
         SoundManager.instance.play("008");
         switch(int(id) - 1)
         {
            case 0:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               GameInSocketOut.sendSingleRoomBegin(3);
               break;
            case 1:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               EntertainmentModeManager.instance.show();
               break;
            case 2:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               LanternRiddlesManager.instance.show();
               break;
            case 3:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               StateManager.setState("worldbossAward");
               break;
            case 4:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               RescueManager.instance.show();
               break;
            case 5:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               self = PlayerManager.Instance.Self;
               if(PlayerManager.Instance.Self.Bag.getItemAt(6) == null)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.weapon"));
                  return;
               }
               if(self.IsMounts)
               {
                  HorseRaceManager.Instance.enterView();
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horseRace.noMount"));
               }
               break;
            case 6:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               if(SevenDoubleManager.instance.isInGame)
               {
                  SevenDoubleManager.instance.addEventListener("sevenDoubleCanEnter",sevenDoubleCanEnterHandler);
                  SocketManager.Instance.out.sendSevenDoubleCanEnter();
               }
               else
               {
                  SevenDoubleManager.instance.loadIcon();
               }
               break;
            case 7:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               CatchBeastManager.instance.show();
               break;
            case 8:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               GameInSocketOut.sendSingleRoomBegin(5);
               break;
            case 9:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               StateManager.setState("roomlist");
               ComponentSetting.SEND_USELOG_ID(3);
               if(PlayerManager.Instance.Self.IsWeakGuildFinish(1) && !PlayerManager.Instance.Self.IsWeakGuildFinish(4))
               {
                  SocketManager.Instance.out.syncWeakStep(4);
               }
               break;
            case 10:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               StateManager.setState("worldbossAward");
               break;
            case 11:
               if(!WeakGuildManager.Instance.checkOpen(76,_levelLimit))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",_levelLimit));
                  return;
               }
               if(ConsortiaBattleManager.instance.isCanEnter)
               {
                  GameInSocketOut.sendSingleRoomBegin(4);
               }
               else if(PlayerManager.Instance.Self.ConsortiaID != 0)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.cannotEnterTxt"));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.cannotEnterTxt2"));
               }
               break;
         }
         DayActivityControl.Instance.dispose();
      }
      
      private function sevenDoubleCanEnterHandler(event:Event) : void
      {
         SevenDoubleManager.instance.removeEventListener("sevenDoubleCanEnter",sevenDoubleCanEnterHandler);
         StateManager.setState("sevenDoubleScene");
      }
      
      public function setBg(number:int) : void
      {
         _bg.gotoAndStop(number % 2 + 1);
      }
      
      private function init(number:int) : void
      {
         _bg = ComponentFactory.Instance.creat("day.list.Back");
         _bg.gotoAndStop(number % 2 + 1);
         addChild(_bg);
         _selectLight = ComponentFactory.Instance.creat("day.sele.light");
         _selectLight.scaleY = 0.957446808510638;
         _selectLight.x = -4;
         _selectLight.y = -3;
         _selectLight.visible = false;
         addChild(_selectLight);
      }
      
      public function setLigthVisible(value:Boolean) : void
      {
         if(_selectLight)
         {
            _selectLight.visible = value;
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("click",mouseClickHander);
         if(_worldBossHelperBtn)
         {
            _worldBossHelperBtn.removeEventListener("click",__worldBossHelperHandler);
         }
         clickSp.removeEventListener("click",clickHander);
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         seleLigthFun = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function get height() : Number
      {
         return 48;
      }
   }
}
