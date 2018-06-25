package cloudBuyLottery.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class LookGoodsFrame extends Frame
   {
      
      public static const SUM_NUMBER:int = 20;
       
      
      private var _list:SimpleTileList;
      
      private var _items:Vector.<BagCell>;
      
      private var _prevBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _boxTempIDList:Vector.<InventoryItemInfo>;
      
      private var _page:int = 1;
      
      public function LookGoodsFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         var _bg1:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("IndividualLottery.TrophyBGI");
         var font:Bitmap = ComponentFactory.Instance.creatBitmap("asset.IndividualLottery.lookFont");
         _list = ComponentFactory.Instance.creatCustomObject("IndividualLottery.TrophyList",[5]);
         var _bg2:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("IndividualLottery.PageCountBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("IndividualLottery.pageTxt");
         _prevBtn = ComponentFactory.Instance.creatComponentByStylename("IndividualLottery.prevBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("IndividualLottery.nextBtn");
         _items = new Vector.<BagCell>();
         _list.beginChanges();
         for(i = 0; i < 20; )
         {
            item = new BagCell(i);
            _items.push(item);
            _list.addChild(item);
            i++;
         }
         _list.commitChanges();
         addToContent(_bg1);
         addToContent(_bg2);
         addToContent(font);
         addToContent(_list);
         addToContent(_pageTxt);
         addToContent(_prevBtn);
         addToContent(_nextBtn);
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("tank.view.caddy.lookTrophy");
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
         _prevBtn.addEventListener("click",_prevClick);
         _nextBtn.addEventListener("click",_nextClick);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         if(_prevBtn)
         {
            _prevBtn.removeEventListener("click",_prevClick);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",_nextClick);
         }
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            hide();
         }
      }
      
      private function _nextClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         page = Number(page) + 1;
         if(page > pageSum())
         {
            page = 1;
         }
         fillPage();
      }
      
      private function _prevClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         page = Number(page) - 1;
         if(page < 1)
         {
            page = pageSum();
         }
         fillPage();
      }
      
      private function fillPage() : void
      {
         var i:* = 0;
         var begin:int = (page - 1) * 20;
         var end:int = page * 20;
         var cellNumber:int = 0;
         for(i = begin; i < end; )
         {
            if(cellNumber < _items.length && i < _boxTempIDList.length)
            {
               _items[cellNumber].info = _boxTempIDList[i];
            }
            else
            {
               _items[cellNumber].info = null;
            }
            i++;
            cellNumber++;
            cellNumber;
         }
      }
      
      private function getTemplateInfo(id:int) : InventoryItemInfo
      {
         var itemInfo:InventoryItemInfo = new InventoryItemInfo();
         itemInfo.TemplateID = id;
         ItemManager.fill(itemInfo);
         return itemInfo;
      }
      
      public function set page(value:int) : void
      {
         _page = value;
         _pageTxt.text = _page + "/" + pageSum();
      }
      
      public function get page() : int
      {
         return _page;
      }
      
      public function pageSum() : int
      {
         return Math.ceil(_boxTempIDList.length / 20);
      }
      
      public function show(list:Vector.<InventoryItemInfo>) : void
      {
         _boxTempIDList = list;
         page = 1;
         fillPage();
         LayerManager.Instance.addToLayer(this,2,true,2);
         this.y = this.y - 50;
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         removeEvents();
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_prevBtn)
         {
            ObjectUtils.disposeObject(_prevBtn);
         }
         _prevBtn = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         _pageTxt = null;
         if(_items != null)
         {
            for(i = 0; i < _items.length; )
            {
               ObjectUtils.disposeObject(_items[i]);
               i++;
            }
            _items = null;
         }
         _boxTempIDList = null;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
