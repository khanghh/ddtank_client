package farm.viewx.poultry
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.PNGHitAreaFactory;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class FarmTree extends Sprite implements Disposeable
   {
       
      
      private var _tree:MovieClip;
      
      private var _leaf:MovieClip;
      
      private var _level:FilterFrameText;
      
      private var _levelNum:int;
      
      private var _treeName:FilterFrameText;
      
      private var _area:Sprite;
      
      public function FarmTree(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onUpdateFarmTreeLevel(param1:FarmEvent) : void{}
      
      public function setLevel(param1:int) : void{}
      
      protected function __onTreeClick(param1:MouseEvent) : void{}
      
      protected function __onTreeOver(param1:MouseEvent) : void{}
      
      protected function __onTreeOut(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
