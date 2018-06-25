package bombKing.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class BKingPrizeTip extends Sprite implements ITransformableTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _label:FilterFrameText;
      
      private var _title:FilterFrameText;
      
      private var _request:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _type:int;
      
      public function BKingPrizeTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeTip.bg");
         addChild(_bg);
         _label = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeTip.labelTxt");
         addChild(_label);
         _label.text = LanguageMgr.GetTranslation("bombKing.prizeTip.label");
         _request = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeTip.requestTxt");
         addChild(_request);
         _request.text = LanguageMgr.GetTranslation("bombKing.prizeTip.request");
         _content = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeTip.contentTxt");
         addChild(_content);
      }
      
      public function get tipData() : Object
      {
         return _type;
      }
      
      public function set tipData(data:Object) : void
      {
         _type = data as int;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
            _title = null;
         }
         _title = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeTip.titleTxt" + _type);
         addChild(_title);
         _title.text = LanguageMgr.GetTranslation("bombKing.prizeTip.title" + _type);
         _content.text = LanguageMgr.GetTranslation("bombKing.prizeTip.content" + _type);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_label);
         _label = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_request);
         _request = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
      }
      
      public function get tipWidth() : int
      {
         return 0;
      }
      
      public function set tipWidth(w:int) : void
      {
      }
      
      public function get tipHeight() : int
      {
         return 0;
      }
      
      public function set tipHeight(h:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
