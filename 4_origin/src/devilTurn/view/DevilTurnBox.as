package devilTurn.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import devilTurn.DevilTurnManager;
   import devilTurn.event.DevilTurnEvent;
   import devilTurn.model.DevilTurnBoxInfo;
   import devilTurn.model.DevilTurnBoxItem;
   import devilTurn.view.mornui.DevilTurnBoxUI;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.utils.DateUtils;
   
   public class DevilTurnBox extends DevilTurnBoxUI
   {
       
      
      private var _giftCell:BagCell;
      
      private var _info:DevilTurnBoxItem;
      
      private var _boxInfo:DevilTurnBoxInfo;
      
      private var _timer:Timer;
      
      private var _showTipsSprite:Sprite;
      
      public function DevilTurnBox()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _giftCell = new BagCell(0,null,false,getBagCellBg());
         addChild(_giftCell);
         addChild(openBtn);
         PositionUtils.setPos(_giftCell,"devilTurn.box.cellPos");
         _timer = new Timer(1000);
         _timer.stop();
         _timer.addEventListener("timer",__onTimer);
         DevilTurnManager.instance.addEventListener("updateboxinfo",__onUpdateBoxInfo);
         _showTipsSprite = getBagCellBg();
         _showTipsSprite.buttonMode = true;
         PositionUtils.setPos(_showTipsSprite,_giftCell);
         addChild(_showTipsSprite);
         _showTipsSprite.addEventListener("rollOver",__onOver);
         _showTipsSprite.addEventListener("rollOut",__onOut);
         _showTipsSprite.addEventListener("click",__onClick);
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc3_:DevilTurnBoxInfo = DevilTurnManager.instance.model.getBoxInfoByID(_info.ID);
         if(_loc3_ == null || _loc3_.count <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.notOpenBox"));
            return;
         }
         if(DevilTurnManager.instance.lotteryRunning)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.lotteryRunning"));
            return;
         }
         if(DevilTurnManager.instance.activityState == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.activityClose"));
            return;
         }
         var _loc2_:DevilTurnDiceView = new DevilTurnDiceView(_info.ID);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
         SocketManager.Instance.out.sendDevilTurnOpenBox(_info.ID);
      }
      
      private function __onUpdateBoxInfo(param1:DevilTurnEvent) : void
      {
         updateView();
      }
      
      public function set info(param1:DevilTurnBoxItem) : void
      {
         _info = param1;
         if(_info)
         {
            updateView();
         }
         else
         {
            _giftCell.info = null;
         }
      }
      
      private function updateView() : void
      {
         if(_info)
         {
            _boxInfo = DevilTurnManager.instance.model.getBoxInfoByID(_info.ID);
            _giftCell.info = ItemManager.Instance.getTemplateById(_info.ID);
            _giftCell.setCount("");
            updateTime();
         }
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         updateTime();
      }
      
      private function updateTime() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(_boxInfo)
         {
            _giftCell.setCount(_boxInfo.count <= 0?"":_boxInfo.count);
            _loc1_ = _boxInfo.expireDate - TimeManager.Instance.NowTime() / 1000;
            if(_loc1_ >= 0)
            {
               _loc2_ = DateUtils.shorTimeRemainArr(_loc1_);
               _loc3_ = _loc2_[0] + ":" + _loc2_[1] + ":" + _loc2_[2];
               dateText.text = _loc3_;
               if(!_timer.running)
               {
                  _timer.start();
               }
            }
            else
            {
               if(_boxInfo.expireDate)
               {
                  SocketManager.Instance.out.sendDevilTurnBoxExpire(_info.ID);
               }
               dateText.text = "";
               _timer.stop();
            }
         }
         else
         {
            dateText.text = "";
         }
      }
      
      private function __onOver(param1:MouseEvent) : void
      {
         openBtn.visible = true;
         _giftCell.dispatchEvent(new MouseEvent("rollOver"));
      }
      
      private function __onOut(param1:MouseEvent) : void
      {
         openBtn.visible = false;
         _giftCell.dispatchEvent(new MouseEvent("rollOut"));
      }
      
      private function getBagCellBg() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,48,48);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         _timer.stop();
         _timer.removeEventListener("timer",__onTimer);
         _timer = null;
         _showTipsSprite.removeEventListener("rollOver",__onOver);
         _showTipsSprite.removeEventListener("rollOut",__onOut);
         _showTipsSprite.removeEventListener("click",__onClick);
         ObjectUtils.disposeObject(_showTipsSprite);
         DevilTurnManager.instance.removeEventListener("updateboxinfo",__onUpdateBoxInfo);
         ObjectUtils.disposeObject(_giftCell);
         _giftCell = null;
         _info = null;
         _showTipsSprite = null;
         super.dispose();
      }
   }
}
