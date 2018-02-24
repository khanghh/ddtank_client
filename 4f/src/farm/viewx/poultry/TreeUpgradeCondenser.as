package farm.viewx.poultry
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.horse.HorseFrameRightBottomItemCell;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TreeUpgradeCondenser extends Sprite implements Disposeable
   {
       
      
      private var _title:Bitmap;
      
      private var _loadingBg:Bitmap;
      
      private var _loading:MovieClip;
      
      private var _exp:FilterFrameText;
      
      private var _checkBox:SelectedCheckButton;
      
      private var _condenserBtn:BaseButton;
      
      private var _itemCell:HorseFrameRightBottomItemCell;
      
      private var _currentExp:Number;
      
      private var _totalExp:Number;
      
      private var _frameIndex:int;
      
      private var _isUpgrade:Boolean;
      
      public function TreeUpgradeCondenser(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onCondenser(param1:PkgEvent) : void{}
      
      public function setExp(param1:Number, param2:Number, param3:int) : void{}
      
      private function setLoadingFrame() : void{}
      
      protected function __onEnterFrame(param1:Event) : void{}
      
      protected function __onCondenserBtnClick(param1:MouseEvent) : void{}
      
      private function set frameIndex(param1:int) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
