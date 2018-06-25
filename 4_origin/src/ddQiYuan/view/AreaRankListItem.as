package ddQiYuan.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddQiYuan.DDQiYuanManager;
   import ddQiYuan.model.DDQiYuanModel;
   import ddt.data.goods.InventoryItemInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class AreaRankListItem extends Sprite implements Disposeable
   {
       
      
      private var _model:DDQiYuanModel;
      
      private var _bgImage:ScaleFrameImage;
      
      private var _topThreeRink:ScaleFrameImage;
      
      private var _rankTf:FilterFrameText;
      
      private var _bagCell:BagCell;
      
      private var _playerNameSP:Component;
      
      private var _playerNameTf:FilterFrameText;
      
      private var _areaRankOfferValueTf:FilterFrameText;
      
      private var _data:Object;
      
      private var _index:int;
      
      public function AreaRankListItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _model = DDQiYuanManager.instance.model;
         _bgImage = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.areaRankItemBg");
         addChild(_bgImage);
         _topThreeRink = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.topThreeRink");
         addChild(_topThreeRink);
         _topThreeRink.visible = false;
         _rankTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.areaRankItemRankTf");
         addChild(_rankTf);
         _rankTf.visible = false;
         var bagCellBg:Bitmap = ComponentFactory.Instance.creatBitmap("DDQiYuan.Pic27");
         _bagCell = new BagCell(1,null,true,bagCellBg,false);
         _bagCell.PicPos = new Point(2,2);
         _bagCell.setContentSize(38,38);
         _bagCell.x = 67;
         _bagCell.y = 3;
         addChild(_bagCell);
         _playerNameSP = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.areaRankPlayerNameSP");
         addChild(_playerNameSP);
         _playerNameTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.areaRankPlayerNameTf");
         _playerNameSP.addChild(_playerNameTf);
         _areaRankOfferValueTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.areaRankOfferValueTf");
         addChild(_areaRankOfferValueTf);
      }
      
      public function setData(selectIndex:int, index:int) : void
      {
         var good:* = null;
         if(selectIndex == 0)
         {
            _data = _model.myAreaRankArr[index];
            good = _model.myAreaRankConfigArr[index];
            _playerNameSP.mouseEnabled = false;
            _playerNameSP.tipData = "";
         }
         else
         {
            _data = _model.allAreaRankArr[index];
            good = _model.allAreaRankConfigArr[index];
            _playerNameSP.mouseEnabled = true;
            _playerNameSP.tipData = _data["areaName"];
         }
         _index = index;
         _bgImage.setFrame(_index % 2 + 1);
         if(_data["rank"] <= 3)
         {
            _topThreeRink.visible = true;
            _rankTf.visible = false;
            _topThreeRink.setFrame(_data["rank"]);
         }
         else
         {
            _topThreeRink.visible = false;
            _rankTf.visible = true;
            _rankTf.text = _data["rank"] + "th";
         }
         var inventoryItemInfo:InventoryItemInfo = DDQiYuanManager.instance.getInventoryItemInfo(good);
         _bagCell.info = inventoryItemInfo;
         _bagCell.setCount(inventoryItemInfo.Count);
         _playerNameTf.text = _data["nickName"];
         _areaRankOfferValueTf.text = _data["offerTimes"];
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _model = null;
         ObjectUtils.disposeObject(_bgImage);
         _bgImage = null;
         ObjectUtils.disposeObject(_topThreeRink);
         _topThreeRink = null;
         ObjectUtils.disposeObject(_rankTf);
         _rankTf = null;
         ObjectUtils.disposeObject(_bagCell);
         _bagCell = null;
         ObjectUtils.disposeObject(_playerNameSP);
         _playerNameSP = null;
         ObjectUtils.disposeObject(_playerNameTf);
         _playerNameTf = null;
         ObjectUtils.disposeObject(_areaRankOfferValueTf);
         _areaRankOfferValueTf = null;
         _data = null;
      }
   }
}
