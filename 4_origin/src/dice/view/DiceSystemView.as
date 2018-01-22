package dice.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import dice.DiceManager;
   import dice.controller.DiceController;
   import dice.event.DiceEvent;
   import dice.vo.DiceAwardCell;
   import dice.vo.DiceAwardInfo;
   import dice.vo.DicePlayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DiceSystemView extends Sprite implements Disposeable
   {
       
      
      private var _controller:DiceController;
      
      private var _bg:Bitmap;
      
      private var _luckIntegralView:DiceLuckIntegralView;
      
      private var _dicePanel:DiceSystemPanel;
      
      private var _rewardPanel:DiceRewarditemsBar;
      
      private var _toolbarView:DiceToolBar;
      
      private var _helpBtn:BaseButton;
      
      private var _helpFrame:Frame;
      
      private var _helpBG:Scale9CornerImage;
      
      private var _okBtn:TextButton;
      
      private var _content:MovieClip;
      
      private var _returnBtn:DiceReturnBar;
      
      private var _player:DicePlayer;
      
      private var _playView:DiceStartView;
      
      private var _treasureBoxArr:Array;
      
      private var start:int;
      
      private var end:int;
      
      public function DiceSystemView(param1:DiceController)
      {
         _treasureBoxArr = [];
         super();
         _controller = param1;
         preInitialize();
         initialize();
         addEvent();
      }
      
      private function preInitialize() : void
      {
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("asset.dice.mainBG");
         _returnBtn = ComponentFactory.Instance.creat("asset.dice.returnMenu");
         _toolbarView = ComponentFactory.Instance.creat("asset.dice.ToolBar");
         _dicePanel = ComponentFactory.Instance.creat("asset.dice.dicePanel");
         _rewardPanel = ComponentFactory.Instance.creat("asset.dice.diceRewardItemsBar");
         _luckIntegralView = ComponentFactory.Instance.creat("asset.dice.luckIntegralView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("asset.dice.helpBtn");
         _playView = ComponentFactory.Instance.creatCustomObject("asset.dice.diceStartView");
         _player = new DicePlayer();
         _loc1_ = 0;
         while(_loc1_ < DiceController.Instance.MAX_LEVEL)
         {
            _treasureBoxArr[_loc1_] = ComponentFactory.Instance.creat("asset.dice.treasureBox.down" + (_loc1_ + 1));
            PositionUtils.setPos(_treasureBoxArr[_loc1_],"asset.dice.treasuerBox.down.pos");
            _loc1_++;
         }
      }
      
      private function initialize() : void
      {
         addChild(_bg);
         addChild(_toolbarView);
         addChild(_returnBtn);
         addChild(_rewardPanel);
         addChild(_dicePanel);
         addChild(_helpBtn);
         _dicePanel.Controller = _controller;
         addChild(_player);
         _player.CurrentPosition = DiceController.Instance.CurrentPosition;
         addChild(_luckIntegralView);
      }
      
      private function addEvent() : void
      {
         _helpBtn.addEventListener("click",__onHelpBtnClick);
         DiceManager.Instance.addEventListener("dice_return",__onReturn);
         DiceController.Instance.addEventListener("dice_level_changed",__onLuckIntegralChanged);
         DiceController.Instance.addEventListener("dice_active_close",__onActiveClose);
         DiceController.Instance.addEventListener("movie_finish",__onMovieFinish);
         DiceController.Instance.addEventListener("get_dice_result_data",__getDiceResultData);
         DiceController.Instance.addEventListener("dice_player_iswalking",__onPlayerState);
         DiceController.Instance.addEventListener("dice_position_changed",__onPlayerPositionChanged);
      }
      
      private function __onReturn(param1:DiceEvent) : void
      {
         SoundManager.instance.play("008");
         StateManager.setState("main");
         dispose();
      }
      
      private function removeEvent() : void
      {
         _helpBtn.removeEventListener("click",__onHelpBtnClick);
         DiceManager.Instance.removeEventListener("dice_return",__onReturn);
         DiceController.Instance.removeEventListener("dice_level_changed",__onLuckIntegralChanged);
         DiceController.Instance.removeEventListener("dice_active_close",__onActiveClose);
         DiceController.Instance.removeEventListener("movie_finish",__onMovieFinish);
         DiceController.Instance.removeEventListener("get_dice_result_data",__getDiceResultData);
         DiceController.Instance.removeEventListener("dice_player_iswalking",__onPlayerState);
         DiceController.Instance.removeEventListener("dice_position_changed",__onPlayerPositionChanged);
      }
      
      private function __onActiveClose(param1:DiceEvent) : void
      {
         StateManager.setState("main");
         dispose();
      }
      
      private function __onMovieFinish(param1:DiceEvent) : void
      {
         _player.PlayerWalkByPosition(start,end);
      }
      
      private function __getDiceResultData(param1:DiceEvent) : void
      {
         start = int(param1.resultData.position);
         end = (start + int(param1.resultData.result)) % DiceController.Instance.CELL_COUNT;
         end = end + (start > end && !DiceController.Instance.hasUsedFirstCell?1:0);
         if(_playView)
         {
            addChild(_playView);
            swapChildren(_playView,_player);
            _playView.play(DiceController.Instance.diceType,param1.resultData.result);
         }
      }
      
      private function __onPlayerPositionChanged(param1:DiceEvent) : void
      {
         _player.CurrentPosition = DiceController.Instance.CurrentPosition;
      }
      
      private function __onPlayerState(param1:DiceEvent) : void
      {
         __onLuckIntegralChanged(null);
         if(!param1.resultData.isWalking)
         {
            _playView.removeAllMovie();
         }
      }
      
      private function __onLuckIntegralChanged(param1:DiceEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(DiceController.Instance.isPlayDownMovie)
         {
            DiceController.Instance.isPlayDownMovie = false;
            _loc2_ = DiceController.Instance.LuckIntegralLevel;
            _loc2_ = _loc2_ - 1;
            if(_loc2_ == -1)
            {
               _loc2_ = DiceController.Instance.MAX_LEVEL - 1;
            }
            _loc3_ = _treasureBoxArr[_loc2_];
            _loc3_.buttonMode = true;
            _loc3_.addEventListener("click",__onDownTreasureBoxClick);
            _loc3_.gotoAndPlay(2);
            LayerManager.Instance.addToLayer(_loc3_,3,false,1);
         }
      }
      
      private function __onDownTreasureBoxClick(param1:MouseEvent) : void
      {
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = undefined;
         var _loc6_:int = 0;
         var _loc4_:MovieClip = param1.currentTarget as MovieClip;
         _loc4_.removeEventListener("click",__onDownTreasureBoxClick);
         if(_loc4_.parent)
         {
            _loc5_ = LanguageMgr.GetTranslation("dice.Levelreward.caption");
            _loc3_ = DiceController.Instance.LuckIntegralLevel;
            _loc3_ = _loc3_ - 1;
            if(_loc3_ == -1)
            {
               _loc3_ = DiceController.Instance.MAX_LEVEL - 1;
            }
            _loc2_ = (DiceController.Instance.AwardLevelInfo[_loc3_] as DiceAwardInfo).templateInfo;
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length)
            {
               _loc5_ = _loc5_ + ((_loc2_[_loc6_] as DiceAwardCell).info.Name + "*" + (_loc2_[_loc6_] as DiceAwardCell).count + "   ");
               _loc6_++;
            }
            MessageTipManager.getInstance().show(_loc5_,0,true);
            _loc4_.parent.removeChild(_loc4_);
         }
      }
      
      private function __onHelpBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_helpFrame == null)
         {
            _helpFrame = ComponentFactory.Instance.creatComponentByStylename("asset.dice.helpFrame");
            _helpBG = ComponentFactory.Instance.creatComponentByStylename("asset.dice.help.BG");
            _okBtn = ComponentFactory.Instance.creatComponentByStylename("asset.dice.helpFrame.OK");
            _content = ComponentFactory.Instance.creat("asset.dice.helpConent");
            _okBtn.text = LanguageMgr.GetTranslation("ok");
            _helpFrame.titleText = LanguageMgr.GetTranslation("dice.help.Title");
            _helpFrame.addToContent(_okBtn);
            _helpFrame.addToContent(_helpBG);
            _helpFrame.addToContent(_content);
            _okBtn.addEventListener("click",__closeHelpFrame);
            _helpFrame.addEventListener("response",__helpFrameRespose);
         }
         LayerManager.Instance.addToLayer(_helpFrame,3,true,2);
      }
      
      protected function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      private function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _helpFrame.parent.removeChild(_helpFrame);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         DiceController.Instance.isPlayDownMovie = false;
         ObjectUtils.disposeObject(_helpFrame);
         _helpFrame = null;
         ObjectUtils.disposeObject(_helpBG);
         _helpBG = null;
         ObjectUtils.disposeObject(_okBtn);
         _okBtn = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_rewardPanel);
         _rewardPanel = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_toolbarView);
         _toolbarView = null;
         ObjectUtils.disposeObject(_dicePanel);
         _dicePanel = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_luckIntegralView);
         _luckIntegralView = null;
         ObjectUtils.disposeObject(_playView);
         _playView = null;
         _loc1_ = _treasureBoxArr.length;
         while(_loc1_ > 0)
         {
            ObjectUtils.disposeObject(_treasureBoxArr[_loc1_ - 1]);
            _treasureBoxArr[_loc1_ - 1] = null;
            _loc1_--;
         }
         _treasureBoxArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
