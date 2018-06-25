package texpSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import texpSystem.controller.TexpManager;
   import texpSystem.data.TexpInfo;
   
   public class TexpTip extends Sprite implements ITransformableTip
   {
      
      public static const NAME_COLOR:Array = [2417048,15938098,3586815,6938624,16756224];
       
      
      private var _tipData:TexpInfo;
      
      private var _tipWidth:int;
      
      private var _tipHeight:int;
      
      private var _bg:ScaleBitmapImage;
      
      private var _name:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      public function TexpTip()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("texpSystem.texpTip.bg");
         _name = ComponentFactory.Instance.creatComponentByStylename("texpSystem.texpTip.name");
         _content = ComponentFactory.Instance.creatComponentByStylename("texpSystem.texpTip.content");
         addChild(_bg);
         addChild(_name);
         addChild(_content);
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
         return _tipHeight;
      }
      
      public function set tipHeight(h:int) : void
      {
         _tipHeight = h;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(data:Object) : void
      {
         if(!data)
         {
            return;
         }
         var info:TexpInfo = data as TexpInfo;
         if(_tipData == info)
         {
            return;
         }
         _tipData = info;
         _name.text = "[" + TexpManager.Instance.getName(_tipData.type) + "]";
         _name.textColor = NAME_COLOR[_tipData.type];
         _content.htmlText = LanguageMgr.GetTranslation("texpSystem.view.TexpView.tipContent",_tipData.lv,TexpManager.Instance.getName(_tipData.type),_tipData.currEffect);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _tipData = null;
      }
   }
}
