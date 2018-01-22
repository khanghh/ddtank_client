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
      
      public function BagLockPSWNeededSelecterListCell(param1:int, param2:int, param3:String, param4:Boolean = false)
      {
         super();
         init();
         _index = param1;
         _checkBox.selected = param2 == 1?false:true;
         if(param4)
         {
            _checkBox.text = LanguageMgr.GetTranslation(param3);
         }
         else
         {
            _checkBox.text = param3;
         }
      }
      
      private function init() : void
      {
         _checkBox = ComponentFactory.Instance.creat("ddtbaglock.check");
         _checkBox.addEventListener("click",onCheckClick);
         addChild(_checkBox);
      }
      
      protected function onCheckClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function dispose() : void
      {
         if(_checkBox != null)
         {
            ObjectUtils.disposeObject(_checkBox);
            _checkBox = null;
         }
         if(_titleText != null)
         {
            ObjectUtils.disposeObject(_titleText);
            _titleText = null;
         }
      }
      
      public function setText(param1:String) : void
      {
         _titleText.text = param1;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function set selected(param1:int) : void
      {
         _checkBox.selected = param1 == 1?false:true;
      }
      
      public function get selected() : int
      {
         return _checkBox.selected == true?0:1;
      }
   }
}
