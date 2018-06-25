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
      
      public function BagLockPSWNeededSelecterListCell($index:int, $selected:int, $text:String, textIsID:Boolean = false)
      {
         super();
         init();
         _index = $index;
         _checkBox.selected = $selected == 1?false:true;
         if(textIsID)
         {
            _checkBox.text = LanguageMgr.GetTranslation($text);
         }
         else
         {
            _checkBox.text = $text;
         }
      }
      
      private function init() : void
      {
         _checkBox = ComponentFactory.Instance.creat("ddtbaglock.check");
         _checkBox.addEventListener("click",onCheckClick);
         addChild(_checkBox);
      }
      
      protected function onCheckClick(me:MouseEvent) : void
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
      
      public function setText(value:String) : void
      {
         _titleText.text = value;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(value:int) : void
      {
         _index = value;
      }
      
      public function set selected(value:int) : void
      {
         _checkBox.selected = value == 1?false:true;
      }
      
      public function get selected() : int
      {
         return _checkBox.selected == true?0:1;
      }
   }
}
