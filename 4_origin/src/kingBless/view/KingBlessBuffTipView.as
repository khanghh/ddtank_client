package kingBless.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   
   public class KingBlessBuffTipView extends BaseTip
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _valueTxtList:Vector.<FilterFrameText>;
      
      private var _tipTxt:FilterFrameText;
      
      private var _valueNameList:Array;
      
      public function KingBlessBuffTipView()
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         super();
         _valueNameList = LanguageMgr.GetTranslation("ddt.kingBless.game.buffTipView.valueNameTxtList").split(",");
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.kingbless.buffTipViewBg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("game.kingbless.tipView.titleTxt");
         _titleTxt.text = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxtList").split(",")[0];
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("game.kingbless.tipView.tipTxt");
         _tipTxt.text = LanguageMgr.GetTranslation("ddt.kingBless.game.buffTipView.tipTxt");
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_tipTxt);
         _valueTxtList = new Vector.<FilterFrameText>(4);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("game.kingbless.tipView.valueTxt");
            _loc1_.y = _loc1_.y + _loc2_ * 20;
            addChild(_loc1_);
            _valueTxtList[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _valueTxtList[_loc3_].text = LanguageMgr.GetTranslation("ddt.kingBless.game.buffTipView.valueTxt",_valueNameList[_loc3_],_loc2_);
            _loc3_++;
         }
         updateSize();
      }
      
      private function updateSize() : void
      {
         var _loc1_:Number = Math.max(_titleTxt.width,_tipTxt.width);
         if(_loc1_ > _bg.width)
         {
            _bg.width = _loc1_ + 20;
         }
      }
      
      override public function get width() : Number
      {
         if(_bg)
         {
            return _bg.width;
         }
         return super.width;
      }
      
      override public function get height() : Number
      {
         if(_bg)
         {
            return _bg.height;
         }
         return super.height;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         var _loc3_:int = 0;
         var _loc2_:* = _valueTxtList;
         for each(var _loc1_ in _valueTxtList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _valueTxtList = null;
         _valueNameList = null;
         super.dispose();
      }
   }
}
