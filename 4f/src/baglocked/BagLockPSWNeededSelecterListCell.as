package baglocked
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BagLockPSWNeededSelecterListCell extends Sprite implements Disposeable
   {
       
      
      private var _checkBox:SelectedCheckButton;
      
      private var _titleText:FilterFrameText;
      
      private var _index:int;
      
      public function BagLockPSWNeededSelecterListCell(param1:int, param2:int, param3:String, param4:Boolean = false){super();}
      
      private function init() : void{}
      
      protected function onCheckClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
      
      public function setText(param1:String) : void{}
      
      public function get index() : int{return 0;}
      
      public function set index(param1:int) : void{}
      
      public function set selected(param1:int) : void{}
      
      public function get selected() : int{return 0;}
   }
}
