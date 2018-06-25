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
      
      public function DiceSystemView(control:DiceController)
      {
         _treasureBoxArr = [];
         super();
         _controller = control;
         preInitialize();
         initialize();
         addEvent();
      }
      
      private function preInitialize() : void
      {
         var i:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("asset.dice.mainBG");
         _returnBtn = ComponentFactory.Instance.creat("asset.dice.returnMenu");
         _toolbarView = ComponentFactory.Instance.creat("asset.dice.ToolBar");
         _dicePanel = ComponentFactory.Instance.creat("asset.dice.dicePanel");
         _rewardPanel = ComponentFactory.Instance.creat("asset.dice.diceRewardItemsBar");
         _luckIntegralView = ComponentFactory.Instance.creat("asset.dice.luckIntegralView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("asset.dice.helpBtn");
         _playView = ComponentFactory.Instance.creatCustomObject("asset.dice.diceStartView");
         _player = new DicePlayer();
         for(i = 0; i < DiceController.Instance.MAX_LEVEL; )
         {
            _treasureBoxArr[i] = ComponentFactory.Instance.creat("asset.dice.treasureBox.down" + (i + 1));
            PositionUtils.setPos(_treasureBoxArr[i],"asset.dice.treasuerBox.down.pos");
            i++;
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
      
      private function __onReturn(event:DiceEvent) : void
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
      
      private function __onActiveClose(event:DiceEvent) : void
      {
         StateManager.setState("main");
         dispose();
      }
      
      private function __onMovieFinish(event:DiceEvent) : void
      {
         _player.PlayerWalkByPosition(start,end);
      }
      
      private function __getDiceResultData(event:DiceEvent) : void
      {
         start = int(event.resultData.position);
         end = (start + int(event.resultData.result)) % DiceController.Instance.CELL_COUNT;
         end = end + (start > end && !DiceController.Instance.hasUsedFirstCell?1:0);
         if(_playView)
         {
            addChild(_playView);
            swapChildren(_playView,_player);
            _playView.play(DiceController.Instance.diceType,event.resultData.result);
         }
      }
      
      private function __onPlayerPositionChanged(event:DiceEvent) : void
      {
         _player.CurrentPosition = DiceController.Instance.CurrentPosition;
      }
      
      private function __onPlayerState(event:DiceEvent) : void
      {
         __onLuckIntegralChanged(null);
         if(!event.resultData.isWalking)
         {
            _playView.removeAllMovie();
         }
      }
      
      private function __onLuckIntegralChanged(event:DiceEvent) : void
      {
         var level:int = 0;
         var movie:* = null;
         if(DiceController.Instance.isPlayDownMovie)
         {
            DiceController.Instance.isPlayDownMovie = false;
            level = DiceController.Instance.LuckIntegralLevel;
            level = level - 1;
            if(level == -1)
            {
               level = DiceController.Instance.MAX_LEVEL - 1;
            }
            movie = _treasureBoxArr[level];
            movie.buttonMode = true;
            movie.addEventListener("click",__onDownTreasureBoxClick);
            movie.gotoAndPlay(2);
            LayerManager.Instance.addToLayer(movie,3,false,1);
         }
      }
      
      private function __onDownTreasureBoxClick(event:MouseEvent) : void
      {
         var msg:* = null;
         var level:int = 0;
         var _templateInfo:* = undefined;
         var i:int = 0;
         var movie:MovieClip = event.currentTarget as MovieClip;
         movie.removeEventListener("click",__onDownTreasureBoxClick);
         if(movie.parent)
         {
            msg = LanguageMgr.GetTranslation("dice.Levelreward.caption");
            level = DiceController.Instance.LuckIntegralLevel;
            level = level - 1;
            if(level == -1)
            {
               level = DiceController.Instance.MAX_LEVEL - 1;
            }
            _templateInfo = (DiceController.Instance.AwardLevelInfo[level] as DiceAwardInfo).templateInfo;
            for(i = 0; i < _templateInfo.length; )
            {
               msg = msg + ((_templateInfo[i] as DiceAwardCell).info.Name + "*" + (_templateInfo[i] as DiceAwardCell).count + "   ");
               i++;
            }
            MessageTipManager.getInstance().show(msg,0,true);
            movie.parent.removeChild(movie);
         }
      }
      
      private function __onHelpBtnClick(event:MouseEvent) : void
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
      
      protected function __helpFrameRespose(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.play("008");
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      private function __closeHelpFrame(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _helpFrame.parent.removeChild(_helpFrame);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
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
         for(i = _treasureBoxArr.length; i > 0; )
         {
            ObjectUtils.disposeObject(_treasureBoxArr[i - 1]);
            _treasureBoxArr[i - 1] = null;
            i--;
         }
         _treasureBoxArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
