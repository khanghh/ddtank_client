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
      
      public function set tipData(data:Object) : void
      {
         var i:int = 0;
         var item:* = null;
         var rule:* = null;
         var wid:int = 0;
         var hei:int = 0;
         var j:int = 0;
         var info:* = null;
         var ruleIma:* = null;
         var k:int = 0;
         if(data != null)
         {
            _data = data as Array;
            var _loc14_:int = 0;
            var _loc13_:* = _itemArr;
            for each(var rookieItem in _itemArr)
            {
               ObjectUtils.disposeObject(rookieItem);
               rookieItem = null;
            }
            _itemArr = [];
            var _loc16_:int = 0;
            var _loc15_:* = _ruleArray;
            for each(var ruleItem in _ruleArray)
            {
               ObjectUtils.disposeObject(ruleItem);
               ruleItem = null;
            }
            _ruleArray = [];
            for(i = 0; i < _data.length; )
            {
               item = new RookieRankTipItem();
               item.y = 23 + i * 22;
               addChild(item);
               _itemArr.push(item);
               if(i < _data.length - 1)
               {
                  rule = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
                  addChild(rule);
                  rule.x = 5;
                  _ruleArray.push(rule);
               }
               i++;
            }
            wid = 0;
            for(j = 0; j < _data.length; )
            {
               info = _data[j];
               _itemArr[j].setData(info);
               if(_itemArr[j].width > wid)
               {
                  wid = _itemArr[j].width;
               }
               hei = hei + _itemArr[j].height;
               if(j < _data.length - 1)
               {
                  ruleIma = _ruleArray[j];
                  ruleIma.y = _itemArr[j].y + _itemArr[j].height;
               }
               j++;
            }
         }
         _bg.width = wid + 24;
         _bg.height = hei + rankTitleTxt.height + 24;
         for(k = 0; k < _ruleArray.length; )
         {
            _ruleArray[k].width = _bg.width - 7;
            k++;
         }
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(w:int) : void
      {
         _tipWidth = w;
      }
      
      public function get tipHeight() : int
      {
         return _bg.height;
      }
      
      public function set tipHeight(h:int) : void
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
