package ringStation.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import labyrinth.data.RankingInfo;
   
   public class ArmoryListItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _itemBG:ScaleFrameImage;
      
      private var _ranking:FilterFrameText;
      
      private var _name:FilterFrameText;
      
      private var _fighting:FilterFrameText;
      
      private var _levelIcon:LevelIcon;
      
      private var _info:RankingInfo;
      
      public function ArmoryListItem(){super();}
      
      private function init() : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
