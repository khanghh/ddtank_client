package horse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import horse.HorseControl;
   import horse.HorseManager;
   import horse.data.HorseTemplateVo;
   import horse.horsePicCherish.HorsePicCherishFrame;
   import trainer.view.NewHandContainer;
   
   public class HorseFrameRightTopView extends Sprite implements Disposeable
   {
       
      
      private var _addPropertyValueTxtList:Vector.<FilterFrameText>;
      
      private var _skillBtn:SimpleBitmapButton;
      
      private var _picBtn:SimpleBitmapButton;
      
      private var _amuletBtn:SimpleBitmapButton;
      
      public function HorseFrameRightTopView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function upHorseHandler(param1:Event) : void{}
      
      private function guideHandler() : void{}
      
      private function skillClickHandler(param1:MouseEvent) : void{}
      
      private function picClickHandler(param1:MouseEvent) : void{}
      
      private function __onAmuletHandler(param1:MouseEvent) : void{}
      
      private function refreshView(param1:Event = null) : void{}
      
      private function refreshNextView(param1:Event = null) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
