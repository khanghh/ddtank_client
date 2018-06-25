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
   
   public class DragonBoatOtherRankItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _data:Object;
      
      private var _rankIconList:Vector.<Bitmap>;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:GradientText;
      
      private var _zoneTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _awardHbox:Sprite;
      
      private var _awardList:Vector.<BagCell>;
      
      private var _awardHboxPos:Point;
      
      public function DragonBoatOtherRankItem()
      {
         var i:int = 0;
         var rankIcon:* = null;
         super();
         _awardList = new Vector.<BagCell>();
         _rankIconList = new Vector.<Bitmap>(3);
         for(i = 0; i < 3; )
         {
            rankIcon = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.cellRankth" + (i + 1));
            addChild(rankIcon);
            _rankIconList[i] = rankIcon;
            i++;
         }
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.cell.rankTxt");
         _nameTxt = VipController.instance.getVipNameTxt(105,1);
         var textFormat:TextFormat = new TextFormat();
         textFormat.align = "center";
         textFormat.bold = true;
         _nameTxt.textField.defaultTextFormat = textFormat;
         _nameTxt.textSize = 14;
         PositionUtils.setPos(_nameTxt,"dragonBoat.mainFrame.cell.nameTxtPos");
         addChild(_nameTxt);
         _zoneTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.cell.scoreTxt");
         PositionUtils.setPos(_zoneTxt,"dragonBoat.mainFrame.otherCell.zoneTxtPos");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.cell.scoreTxt");
         PositionUtils.setPos(_scoreTxt,"dragonBoat.mainFrame.otherCell.scoreTxtPos");
         _awardHboxPos = ComponentFactory.Instance.creatCustomObject("dragonBoat.shopFrame.cellAwardOtherPos");
         _awardHbox = new Sprite();
         _awardHbox.y = _awardHboxPos.y;
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_zoneTxt);
         addChild(_scoreTxt);
         addChild(_awardHbox);
      }
      
      private function clearAwardCell() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _awardList;
         for each(var _bagCell in _awardList)
         {
            _bagCell.info = null;
         }
      }
      
      private function updateAwardCell($index:int, $info:ItemTemplateInfo) : void
      {
         var _awardCell:BagCell = null;
         if($index > _awardList.length - 1)
         {
            _awardCell = new BagCell(1,$info,true,null,false);
            _awardCell.tipGapH = 0;
            _awardCell.tipGapV = 0;
            _awardCell.scaleX = 0.6;
            _awardCell.scaleY = 0.6;
         }
         else
         {
            _awardCell = _awardList[$index];
         }
         _awardCell.info = $info;
         _awardCell.x = _awardHbox.width + 5;
         _awardHbox.addChild(_awardCell);
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(value:*) : void
      {
         var i:int = 0;
         var _itemInfo:* = null;
         _data = value;
         var rank:int = _data.rank;
         setRankIconVisible(rank);
         if(rank >= 1 && rank <= 3)
         {
            _rankTxt.visible = false;
         }
         else
         {
            _rankTxt.text = rank + "th";
            _rankTxt.visible = true;
         }
         _nameTxt.text = _data.name;
         _zoneTxt.text = _data.zone;
         _scoreTxt.text = _data.score;
         if(_awardHbox)
         {
            while(_awardHbox.numChildren > 0)
            {
               _awardHbox.removeChild(_awardHbox.getChildAt(0));
            }
         }
         clearAwardCell();
         for(i = 0; i < _data.itemInfoArr.length; )
         {
            _itemInfo = _data.itemInfoArr[i] as InventoryItemInfo;
            updateAwardCell(i,_itemInfo);
            i++;
         }
         _awardHbox.x = _awardHboxPos.x + (120 - _awardHbox.width) / 2;
      }
      
      private function setRankIconVisible(rank:int) : void
      {
         var i:int = 0;
         var len:int = _rankIconList.length;
         for(i = 1; i <= len; )
         {
            if(rank == i)
            {
               _rankIconList[i - 1].visible = true;
            }
            else
            {
               _rankIconList[i - 1].visible = false;
            }
            i++;
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         if(_awardHbox)
         {
            ObjectUtils.disposeAllChildren(_awardHbox);
            _awardHbox = null;
         }
         _awardHboxPos = null;
         _awardList = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         _rankIconList = null;
         _rankTxt = null;
         _nameTxt = null;
         _zoneTxt = null;
         _scoreTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
