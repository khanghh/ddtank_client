package rank.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class RankCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _titlefield:FilterFrameText;
      
      private var _selected:Boolean = false;
      
      private var _info:GmActivityInfo;
      
      public function RankCell(param1:GmActivityInfo){super();}
      
      public function get info() : GmActivityInfo{return null;}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      private function initUI() : void{}
      
      public function dispose() : void{}
   }
}
