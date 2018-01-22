package oldPlayerComeBack.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.DiceRoll;
   import flash.events.MouseEvent;
   import oldPlayerComeBack.OldPlayerComeBackControl;
   import oldPlayerComeBack.OldPlayerComeBackManager;
   import oldPlayerComeBack.view.task.OldPlayerTaskFrame;
   
   public class OldPlayerComeBackFrame extends Frame
   {
      
      private static const DICE_TEMPLATE_ID:int = 12571;
       
      
      private var _view:OldPlayerComeBackView;
      
      private var _dispatchTaskBtn:SimpleBitmapButton;
      
      private var _rollDice:SimpleBitmapButton;
      
      private var _diceCountTxt:FilterFrameText;
      
      private var _diceDecTxt:FilterFrameText;
      
      private var _isStartRollDice:Boolean = false;
      
      private var _diceRollMc:DiceRoll;
      
      private var _control:OldPlayerComeBackControl;
      
      private var _taskFrame:OldPlayerTaskFrame;
      
      public function OldPlayerComeBackFrame()
      {
         super();
         initEvent();
      }
      
      public function set initControl(param1:OldPlayerComeBackControl) : void
      {
         _control = param1;
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("oldPlayerComeBack.titleTxt");
         _dispatchTaskBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.dispatchTaskBtn");
         addToContent(_dispatchTaskBtn);
         _rollDice = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.rollDiceBtn");
         addToContent(_rollDice);
         _diceCountTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.diceCountTxt");
         addToContent(_diceCountTxt);
         updateDiceCount();
         _diceDecTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.diceDecTxt");
         addToContent(_diceDecTxt);
         updateDiceDec();
         _view = new OldPlayerComeBackView();
         PositionUtils.setPos(_view,"oldPlayerComeBack.viewPos");
         addToContent(_view);
         _diceRollMc = new DiceRoll();
         PositionUtils.setPos(_diceRollMc,"oldPlayerComeBack.diceViewPos");
         addToContent(_diceRollMc);
      }
      
      public function get diceRollMc() : DiceRoll
      {
         return _diceRollMc;
      }
      
      private function updateDiceDec() : void
      {
         _diceDecTxt.text = LanguageMgr.GetTranslation("oldPlayerComeBack.diceDecTxt") + OldPlayerComeBackManager.instance.activityTimeRange;
      }
      
      public function updateDiceCount() : void
      {
         _diceCountTxt.text = LanguageMgr.GetTranslation("oldPlayerComeBack.diceCount.txt",PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12571));
      }
      
      private function initEvent() : void
      {
         if(_dispatchTaskBtn)
         {
            _dispatchTaskBtn.addEventListener("click",__dispatchTaskBtnClickHandler);
         }
         if(_rollDice)
         {
            _rollDice.addEventListener("click",__rollDiceBtnClickHandler);
         }
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__updateDiceCountHandler);
      }
      
      private function removeEvent() : void
      {
         if(_dispatchTaskBtn)
         {
            _dispatchTaskBtn.removeEventListener("click",__dispatchTaskBtnClickHandler);
         }
         if(_rollDice)
         {
            _rollDice.removeEventListener("click",__rollDiceBtnClickHandler);
         }
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__updateDiceCountHandler);
      }
      
      private function __updateDiceCountHandler(param1:BagEvent) : void
      {
         updateDiceCount();
      }
      
      private function __rollDiceBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_isStartRollDice)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("oldPlayerComeBack.rollDiceFastMsg"));
            return;
         }
         var _loc2_:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(12571);
         if(_loc2_ == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("oldPlayerComeBack.diceCountNoHaveMsg"));
            return;
         }
         _isStartRollDice = true;
         _rollDice.enable = !_isStartRollDice;
         _diceRollMc.resetFrame();
         OldPlayerComeBackManager.instance.sendRollDice(_loc2_.Place);
      }
      
      private function __dispatchTaskBtnClickHandler(param1:MouseEvent) : void
      {
         _taskFrame = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.taskViewFrame");
         if(_taskFrame)
         {
            LayerManager.Instance.addToLayer(_taskFrame,3,true,1);
         }
      }
      
      public function set rollDiceComplete(param1:Boolean) : void
      {
         _isStartRollDice = !param1;
         _rollDice.enable = !_isStartRollDice;
      }
      
      public function get comeBackView() : OldPlayerComeBackView
      {
         return _view;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_taskFrame)
         {
            ObjectUtils.disposeObject(_taskFrame);
         }
         _taskFrame = null;
         if(_dispatchTaskBtn)
         {
            ObjectUtils.disposeObject(_dispatchTaskBtn);
         }
         _dispatchTaskBtn = null;
         if(_rollDice)
         {
            ObjectUtils.disposeObject(_rollDice);
         }
         _rollDice = null;
         if(_diceCountTxt)
         {
            ObjectUtils.disposeObject(_diceCountTxt);
         }
         _diceCountTxt = null;
         if(_diceDecTxt)
         {
            ObjectUtils.disposeObject(_diceDecTxt);
         }
         _diceDecTxt = null;
         if(_view)
         {
            _view.dispose();
         }
         _view = null;
         if(_control)
         {
            _control.dispose();
         }
         _control = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
