package dragonBoat.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import vip.VipController;
   
   public class DragonBoatSelfRankItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _data:Object;
      
      private var _rankIconList:Vector.<Bitmap>;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:GradientText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _awardHbox:Sprite;
      
      private var _awardList:Vector.<BagCell>;
      
      private var _awardHboxPos:Point;
      
      public function DragonBoatSelfRankItem(){super();}
      
      private function clearAwardCell() : void{}
      
      private function updateAwardCell(param1:int, param2:ItemTemplateInfo) : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      private function setRankIconVisible(param1:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
