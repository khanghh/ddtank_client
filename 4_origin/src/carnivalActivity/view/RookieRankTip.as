package carnivalActivity.view
{
   import carnivalActivity.RookieRankInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class RookieRankTip extends Sprite implements ITransformableTip, Disposeable
   {
       
      
      private var rankTitleTxt:FilterFrameText;
      
      private var nickNameTitleTxt:FilterFrameText;
      
      private var fightPowerTitleTxt:FilterFrameText;
      
      private var _bg:ScaleBitmapImage;
      
      private var _tipWidth:int;
      
      private var _tipHeight:int;
      
      private var _txtVec:Vector.<FilterFrameText>;
      
      private var _ruleArray:Array;
      
      private var _data:Array;
      
      private var _itemArr:Array;
      
      public function RookieRankTip()
      {
         super();
         _txtVec = new Vector.<FilterFrameText>();
         _ruleArray = [];
         _itemArr = [];
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         addChild(_bg);
         rankTitleTxt = ComponentFactory.Instance.creatComponentByStylename("carnival.rookieRank.titleTxt");
         addChild(rankTitleTxt);
         rankTitleTxt.text = LanguageMgr.GetTranslation("wonderful.rookieRank.title1");
         PositionUtils.setPos(rankTitleTxt,"carnival.rookieRank.titlePos1");
         nickNameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("carnival.rookieRank.titleTxt");
         addChild(nickNameTitleTxt);
         nickNameTitleTxt.text = LanguageMgr.GetTranslation("wonderful.rookieRank.title2");
         PositionUtils.setPos(nickNameTitleTxt,"carnival.rookieRank.titlePos2");
         fightPowerTitleTxt = ComponentFactory.Instance.creatComponentByStylename("carnival.rookieRank.titleTxt");
         addChild(fightPowerTitleTxt);
         fightPowerTitleTxt.text = LanguageMgr.GetTranslation("wonderful.rookieRank.title3");
         PositionUtils.setPos(fightPowerTitleTxt,"carnival.rookieRank.titlePos3");
      }
      
      public function get tipData() : Object
      {
         return _data;
      }
      
      public function set tipData(param1:Object) : void
      {
         var _loc12_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:* = null;
         var _loc8_:* = null;
         var _loc10_:int = 0;
         if(param1 != null)
         {
            _data = param1 as Array;
            var _loc14_:int = 0;
            var _loc13_:* = _itemArr;
            for each(var _loc2_ in _itemArr)
            {
               ObjectUtils.disposeObject(_loc2_);
               _loc2_ = null;
            }
            _itemArr = [];
            var _loc16_:int = 0;
            var _loc15_:* = _ruleArray;
            for each(var _loc7_ in _ruleArray)
            {
               ObjectUtils.disposeObject(_loc7_);
               _loc7_ = null;
            }
            _ruleArray = [];
            _loc12_ = 0;
            while(_loc12_ < _data.length)
            {
               _loc6_ = new RookieRankTipItem();
               _loc6_.y = 23 + _loc12_ * 22;
               addChild(_loc6_);
               _itemArr.push(_loc6_);
               if(_loc12_ < _data.length - 1)
               {
                  _loc5_ = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
                  addChild(_loc5_);
                  _loc5_.x = 5;
                  _ruleArray.push(_loc5_);
               }
               _loc12_++;
            }
            _loc4_ = 0;
            _loc9_ = 0;
            while(_loc9_ < _data.length)
            {
               _loc11_ = _data[_loc9_];
               _itemArr[_loc9_].setData(_loc11_);
               if(_itemArr[_loc9_].width > _loc4_)
               {
                  _loc4_ = _itemArr[_loc9_].width;
               }
               _loc3_ = _loc3_ + _itemArr[_loc9_].height;
               if(_loc9_ < _data.length - 1)
               {
                  _loc8_ = _ruleArray[_loc9_];
                  _loc8_.y = _itemArr[_loc9_].y + _itemArr[_loc9_].height;
               }
               _loc9_++;
            }
         }
         _bg.width = _loc4_ + 24;
         _bg.height = _loc3_ + rankTitleTxt.height + 24;
         _loc10_ = 0;
         while(_loc10_ < _ruleArray.length)
         {
            _ruleArray[_loc10_].width = _bg.width - 7;
            _loc10_++;
         }
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(param1:int) : void
      {
         _tipWidth = param1;
      }
      
      public function get tipHeight() : int
      {
         return _bg.height;
      }
      
      public function set tipHeight(param1:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _txtVec = null;
         _ruleArray = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
