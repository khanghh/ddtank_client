package kingDivision.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import kingDivision.data.KingDivisionConsortionItemInfo;
   
   public class KingDivisionConsortionListItem extends Sprite implements Disposeable
   {
       
      
      private var _itemBG:ScaleFrameImage;
      
      private var _index:int;
      
      private var _consortionName:FilterFrameText;
      
      private var _points:FilterFrameText;
      
      private var _count:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _topThreeRink:ScaleFrameImage;
      
      private var _ring:FilterFrameText;
      
      public function KingDivisionConsortionListItem(param1:int){super();}
      
      private function init() : void{}
      
      public function set info(param1:KingDivisionConsortionItemInfo) : void{}
      
      private function setRink() : void{}
      
      override public function get height() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
