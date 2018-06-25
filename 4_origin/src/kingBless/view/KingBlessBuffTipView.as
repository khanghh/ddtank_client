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
         var i:int = 0;
         var valueTxt:* = null;
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
         for(i = 0; i < 4; )
         {
            valueTxt = ComponentFactory.Instance.creatComponentByStylename("game.kingbless.tipView.valueTxt");
            valueTxt.y = valueTxt.y + i * 20;
            addChild(valueTxt);
            _valueTxtList[i] = valueTxt;
            i++;
         }
      }
      
      override public function set tipData(data:Object) : void
      {
         var i:int = 0;
         var value:int = data;
         for(i = 0; i < 4; )
         {
            _valueTxtList[i].text = LanguageMgr.GetTranslation("ddt.kingBless.game.buffTipView.valueTxt",_valueNameList[i],value);
            i++;
         }
         updateSize();
      }
      
      private function updateSize() : void
      {
         var maxWidth:Number = Math.max(_titleTxt.width,_tipTxt.width);
         if(maxWidth > _bg.width)
         {
            _bg.width = maxWidth + 20;
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
         for each(var tmp in _valueTxtList)
         {
            ObjectUtils.disposeObject(tmp);
         }
         _valueTxtList = null;
         _valueNameList = null;
         super.dispose();
      }
   }
}
