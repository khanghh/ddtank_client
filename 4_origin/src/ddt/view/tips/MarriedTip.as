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
      
      override public function set tipData(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(param1 != _data)
         {
            _data = param1;
            _contentTxt.text = LanguageMgr.GetTranslation("core.MarriedTipLatterText" + (String(!!_data.gender?"Husband":"Wife")),_data.nickName);
            _loc2_ = _contentTxt.text.indexOf(_data.nickName);
            if(_loc2_ > -1)
            {
               _contentTxt.setTextFormat(_nickNameTF,_loc2_,_loc2_ + _data.nickName.length);
            }
            updateTransform();
         }
      }
      
      private function fitTextWidth() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc4_:Point = localToGlobal(new Point(0,0));
         var _loc3_:int = _loc4_.x + width - 1000;
         if(_loc3_ > 0)
         {
            _loc2_ = _contentTxt.text;
            _contentTxt.text = _loc2_.substring(0,_loc2_.length - 3);
            _loc1_ = _contentTxt.getCharIndexAtPoint(_contentTxt.width - _loc3_ - 20,5);
            _contentTxt.text = _contentTxt.text.substring(0,_loc1_) + "..." + _loc2_.substr(_loc2_.length - 3);
         }
         _contentTxt.setTextFormat(_nickNameTF,0,_contentTxt.length - 3);
         updateTransform();
      }
      
      override public function set x(param1:Number) : void
      {
         .super.x = param1;
      }
   }
}
