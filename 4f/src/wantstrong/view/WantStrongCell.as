package wantstrong.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import wantstrong.WantStrongControl;
   import wantstrong.data.WantStrongMenuData;
   
   public class WantStrongCell extends Sprite implements Disposeable
   {
       
      
      private var _info:Vector.<WantStrongMenuData>;
      
      private var _bg:ScaleFrameImage;
      
      private var _selected:Boolean = false;
      
      private var _titlefield:FilterFrameText;
      
      private var _title:String;
      
      public function WantStrongCell(param1:Vector.<WantStrongMenuData>, param2:String){super();}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function get info() : Vector.<WantStrongMenuData>{return null;}
      
      public function openItem() : void{}
      
      private function initUI() : void{}
      
      public function dispose() : void{}
   }
}
