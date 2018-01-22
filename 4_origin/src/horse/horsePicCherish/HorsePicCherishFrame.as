package horse.horsePicCherish
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import horse.HorseManager;
   import horse.data.HorsePicCherishVo;
   
   public class HorsePicCherishFrame extends Frame
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
         _propertyNamePosArr = [new Point(17,356),new Point(127,365),new Point(239,365),new Point(359,365),new Point(474,365)];
         _propertyValuePosArr = [new Point(78,365),new Point(188,365),new Point(308,365),new Point(428,365),new Point(548,365)];
         super();
         initView();
         initEvent();
         initData();
         updateView();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _titleText = LanguageMgr.GetTranslation("horse.horsePicCherish.frameTitleTxt");
         _scaleBg = ComponentFactory.Instance.creatComponentByStylename("horse.HorsePicCherish.scale9ImageBg");
         addToContent(_scaleBg);
         _bg = ComponentFactory.Instance.creat("horse.pic.bg");
         addToContent(_bg);
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("horse.HorsePicCherish.leftBtn");
         addToContent(_leftBtn);
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("horse.HorsePicCherish.rightBtn");
         addToContent(_rightBtn);
         _propertyNameArr = [];
         _propertyValueArr = [];
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("horse.picCHerish.addPorpertyNameTxt");
            _loc2_.text = _nameStrList[_loc3_];
            addToContent(_loc2_);
            PositionUtils.setPos(_loc2_,_propertyNamePosArr[_loc3_]);
            _propertyNameArr.push(_loc2_);
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("horse.picCHerish.addPorpertyValueTxt");
            _loc1_.text = "0";
            addToContent(_loc1_);
            PositionUtils.setPos(_loc1_,_propertyValuePosArr[_loc3_]);
            _propertyValueArr.push(_loc1_);
            _loc3_++;
         }
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("horsePicCherish.pageBG");
         addToContent(_pageBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("horsePicCherish.pageTxt");
         addToContent(_pageTxt);
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
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _itemList = new Vector.<HorsePicCherishItem>();
         _horsePicCherishList = HorseManager.instance.getHorsePicCherishData();
         _loc4_ = 0;
         while(_loc4_ < _horsePicCherishList.length)
         {
            _loc1_ = new HorsePicCherishItem(_horsePicCherishList[_loc4_].ID,_horsePicCherishList[_loc4_]);
            _loc1_.tipStyle = "horse.horsePicCherish.HorsePicCherishTip";
            _loc1_.tipDirctions = "2,7,5,1,4,6";
            _itemList.push(_loc1_);
            _loc4_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 8 - _horsePicCherishList.length % 8)
         {
            _loc2_ = new HorsePicCherishItem(-1,null);
            _itemList.push(_loc2_);
            _loc3_++;
         }
         _sumPage = Math.ceil(_itemList.length / 8);
      }
      
      private function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:Dictionary = PlayerManager.Instance.Self.horsePicCherishDic;
         var _loc1_:Vector.<HorsePicCherishVo> = HorseManager.instance.getHorsePicCherishData();
         var _loc15_:int = 0;
         var _loc14_:* = _loc2_;
         for(var _loc10_ in _loc2_)
         {
            var _loc13_:int = 0;
            var _loc12_:* = _loc1_;
            for each(var _loc5_ in _loc1_)
            {
               if(int(_loc10_) == _loc5_.ID)
               {
                  _loc3_ = _loc3_ + _loc5_.AddHurt;
                  _loc4_ = _loc4_ + _loc5_.AddGuard;
                  _loc8_ = _loc8_ + _loc5_.AddBlood;
                  _loc9_ = _loc9_ + _loc5_.MagicAttack;
                  _loc7_ = _loc7_ + _loc5_.MagicDefence;
                  break;
               }
            }
         }
         var _loc6_:Array = [_loc3_,_loc4_,_loc8_,_loc9_,_loc7_];
         _loc11_ = 0;
         while(_loc11_ < _propertyValueArr.length)
         {
            _propertyValueArr[_loc11_].text = _loc6_[_loc11_];
            _loc11_++;
         }
      }
      
      public function set index(param1:int) : void
      {
         _currentIndex = param1;
         _pageTxt.text = _currentIndex + "/" + _sumPage;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(!_itemListView)
         {
            _itemListView = new HorsePicCherishItemListView(_itemList);
            _itemListView.x = 8;
            _itemListView.y = 3;
            addToContent(_itemListView);
         }
         _itemListView.show(_currentIndex);
      }
      
      protected function __rightHandler(param1:MouseEvent) : void
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
      
      protected function __leftHandler(param1:MouseEvent) : void
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
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
      
      override public function dispose() : void
      {
         removeEvent();
         HorseManager.instance.isSkipFromBagView = false;
         HorseManager.instance.updateCherishPropertyFunc = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_scaleBg);
         _scaleBg = null;
         ObjectUtils.disposeObject(_itemListView);
         _itemListView = null;
         _itemList = null;
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
         var _loc4_:int = 0;
         var _loc3_:* = _propertyNameArr;
         for each(var _loc2_ in _propertyNameArr)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         _propertyNameArr = null;
         var _loc6_:int = 0;
         var _loc5_:* = _propertyValueArr;
         for each(var _loc1_ in _propertyValueArr)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
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
         super.dispose();
      }
   }
}
