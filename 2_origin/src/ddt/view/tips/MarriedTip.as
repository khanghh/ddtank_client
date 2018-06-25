package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import flash.geom.Point;
   import flash.text.TextFormat;
   
   public class MarriedTip extends OneLineTip
   {
       
      
      private var _nickNameTF:TextFormat;
      
      public function MarriedTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.MarriedTipBg");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
         _nickNameTF = ComponentFactory.Instance.model.getSet("core.MarriedTipNickNameTF");
         addChild(_bg);
         addChild(_contentTxt);
      }
      
      override public function set tipData(data:Object) : void
      {
         var pos:int = 0;
         if(data != _data)
         {
            _data = data;
            _contentTxt.text = LanguageMgr.GetTranslation("core.MarriedTipLatterText" + (String(!!_data.gender?"Husband":"Wife")),_data.nickName);
            pos = _contentTxt.text.indexOf(_data.nickName);
            if(pos > -1)
            {
               _contentTxt.setTextFormat(_nickNameTF,pos,pos + _data.nickName.length);
            }
            updateTransform();
         }
      }
      
      private function fitTextWidth() : void
      {
         var originStr:* = null;
         var tempIndex:int = 0;
         var pos:Point = localToGlobal(new Point(0,0));
         var len:int = pos.x + width - 1000;
         if(len > 0)
         {
            originStr = _contentTxt.text;
            _contentTxt.text = originStr.substring(0,originStr.length - 3);
            tempIndex = _contentTxt.getCharIndexAtPoint(_contentTxt.width - len - 20,5);
            _contentTxt.text = _contentTxt.text.substring(0,tempIndex) + "..." + originStr.substr(originStr.length - 3);
         }
         _contentTxt.setTextFormat(_nickNameTF,0,_contentTxt.length - 3);
         updateTransform();
      }
      
      override public function set x(value:Number) : void
      {
         .super.x = value;
      }
   }
}
