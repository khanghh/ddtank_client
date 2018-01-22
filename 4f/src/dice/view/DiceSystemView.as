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
      
      public function DiceSystemView(param1:DiceController){super();}
      
      private function preInitialize() : void{}
      
      private function initialize() : void{}
      
      private function addEvent() : void{}
      
      private function __onReturn(param1:DiceEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __onActiveClose(param1:DiceEvent) : void{}
      
      private function __onMovieFinish(param1:DiceEvent) : void{}
      
      private function __getDiceResultData(param1:DiceEvent) : void{}
      
      private function __onPlayerPositionChanged(param1:DiceEvent) : void{}
      
      private function __onPlayerState(param1:DiceEvent) : void{}
      
      private function __onLuckIntegralChanged(param1:DiceEvent) : void{}
      
      private function __onDownTreasureBoxClick(param1:MouseEvent) : void{}
      
      private function __onHelpBtnClick(param1:MouseEvent) : void{}
      
      protected function __helpFrameRespose(param1:FrameEvent) : void{}
      
      private function __closeHelpFrame(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
