package horse.horsePicCherish
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import horse.HorseManager;
   import horse.data.HorsePicCherishVo;
   
   public class HorsePicCherishFrame extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _scaleBg:ScaleBitmapImage;
      
      private var _leftBtn:SimpleBitmapButton;
      
      private var _rightBtn:SimpleBitmapButton;
      
      private var _currentIndex:int = 1;
      
      private var _sumPage:int;
      
      private var _itemListView:HorsePicCherishItemListView;
      
      private var _itemList:Vector.<HorsePicCherishItem>;
      
      private var _horsePicCherishList:Vector.<HorsePicCherishVo>;
      
      private var _nameStrList:Array;
      
      private var _propertyNameArr:Array;
      
      private var _propertyNamePosArr:Array;
      
      private var _propertyValueArr:Array;
      
      private var _propertyValuePosArr:Array;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      public function HorsePicCherishFrame()
      {
         _nameStrList = LanguageMgr.GetTranslation("horse.addPropertyNameStr").split(",");
         _propertyNamePosArr = [new Point(9,363),new Point(173,363),new Point(318,363),new Point(465,363),new Point(601,363)];
         _propertyValuePosArr = [new Point(78,364),new Point(224,364),new Point(370,364),new Point(516,364),new Point(662,364)];
         super();
         initView();
         initEvent();
         initData();
         updateView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var nameTxt:* = null;
         var valueTxt:* = null;
         _bg = ComponentFactory.Instance.creat("horse.pic.bg");
         _bg.x = -2;
         _bg.y = -6;
         addChild(_bg);
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("horse.HorsePicCherish.leftBtn");
         addChild(_leftBtn);
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("horse.HorsePicCherish.rightBtn");
         addChild(_rightBtn);
         _propertyNameArr = [];
         _propertyValueArr = [];
         for(i = 0; i < 5; )
         {
            nameTxt = ComponentFactory.Instance.creatComponentByStylename("horse.picCHerish.addPorpertyNameTxt");
            nameTxt.text = _nameStrList[i];
            addChild(nameTxt);
            PositionUtils.setPos(nameTxt,_propertyNamePosArr[i]);
            _propertyNameArr.push(nameTxt);
            valueTxt = ComponentFactory.Instance.creatComponentByStylename("horse.picCHerish.addPorpertyValueTxt");
            valueTxt.text = "0";
            addChild(valueTxt);
            PositionUtils.setPos(valueTxt,_propertyValuePosArr[i]);
            _propertyValueArr.push(valueTxt);
            i++;
         }
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("horsePicCherish.pageBG");
         addChild(_pageBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("horsePicCherish.pageTxt");
         addChild(_pageTxt);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _leftBtn.addEventListener("click",__leftHandler);
         _rightBtn.addEventListener("click",__rightHandler);
         HorseManager.instance.updateCherishPropertyFunc = updateView;
      }
      
      private function initData() : void
      {
         var i:int = 0;
         var item:* = null;
         var j:int = 0;
         var itemUnKnown:* = null;
         _itemList = new Vector.<HorsePicCherishItem>();
         _horsePicCherishList = HorseManager.instance.getHorsePicCherishData();
         for(i = 0; i < _horsePicCherishList.length; )
         {
            item = new HorsePicCherishItem(_horsePicCherishList[i].ID,_horsePicCherishList[i]);
            item.tipStyle = "horse.horsePicCherish.HorsePicCherishTip";
            item.tipDirctions = int((i + 1) % 5) == 0?"1,7,5":"2,7,5";
            _itemList.push(item);
            i++;
         }
         var fillLen:int = _horsePicCherishList.length % 10;
         if(fillLen != 0)
         {
            fillLen = 10 - fillLen;
         }
         j = 0;
         while(j < fillLen)
         {
            itemUnKnown = new HorsePicCherishItem(-1,null);
            _itemList.push(itemUnKnown);
            j++;
         }
         _sumPage = Math.ceil(_itemList.length / 10);
      }
      
      private function updateView() : void
      {
         var hurt:int = 0;
         var guard:int = 0;
         var blood:int = 0;
         var magicAttack:int = 0;
         var magicDefence:int = 0;
         var i:int = 0;
         var dataDic:Dictionary = PlayerManager.Instance.Self.horsePicCherishDic;
         var dataVec:Vector.<HorsePicCherishVo> = HorseManager.instance.getHorsePicCherishData();
         var _loc15_:int = 0;
         var _loc14_:* = dataDic;
         for(var key in dataDic)
         {
            var _loc13_:int = 0;
            var _loc12_:* = dataVec;
            for each(var data in dataVec)
            {
               if(int(key) == data.ID)
               {
                  hurt = hurt + data.AddHurt;
                  guard = guard + data.AddGuard;
                  blood = blood + data.AddBlood;
                  magicAttack = magicAttack + data.MagicAttack;
                  magicDefence = magicDefence + data.MagicDefence;
                  break;
               }
            }
         }
         var temp:Array = [hurt,guard,blood,magicAttack,magicDefence];
         for(i = 0; i < _propertyValueArr.length; )
         {
            _propertyValueArr[i].text = temp[i];
            i++;
         }
      }
      
      public function set index(value:int) : void
      {
         _currentIndex = value;
         _pageTxt.text = _currentIndex + "/" + _sumPage;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(!_itemListView)
         {
            _itemListView = new HorsePicCherishItemListView(_itemList);
            _itemListView.x = 6;
            _itemListView.y = 1;
            addChild(_itemListView);
         }
         _itemListView.show(_currentIndex);
      }
      
      protected function __rightHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_currentIndex >= _sumPage)
         {
            _currentIndex = 1;
         }
         else
         {
            _currentIndex = Number(_currentIndex) + 1;
         }
         index = _currentIndex;
      }
      
      protected function __leftHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_currentIndex <= 1)
         {
            _currentIndex = _sumPage;
         }
         else
         {
            _currentIndex = Number(_currentIndex) - 1;
         }
         index = _currentIndex;
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _leftBtn.removeEventListener("click",__leftHandler);
         _rightBtn.removeEventListener("click",__rightHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         HorseManager.instance.isSkipFromBagView = false;
         HorseManager.instance.updateCherishPropertyFunc = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_itemListView);
         _itemListView = null;
         _itemList = null;
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
         var _loc4_:int = 0;
         var _loc3_:* = _propertyNameArr;
         for each(var txt in _propertyNameArr)
         {
            ObjectUtils.disposeObject(txt);
            txt = null;
         }
         _propertyNameArr = null;
         var _loc6_:int = 0;
         var _loc5_:* = _propertyValueArr;
         for each(var valueTxt in _propertyValueArr)
         {
            ObjectUtils.disposeObject(valueTxt);
            valueTxt = null;
         }
         _propertyValueArr = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
