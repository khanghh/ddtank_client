package store
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   
   public class HelpPrompt extends Component
   {
       
      
      private var _bg9Scale:Scale9CornerImage;
      
      public var bg9ScalseStyle:String;
      
      public var contentStyle:String;
      
      private var contentArr:Array;
      
      public function HelpPrompt()
      {
         super();
      }
      
      override protected function onProppertiesUpdate() : void
      {
         var i:int = 0;
         var content:* = null;
         super.onProppertiesUpdate();
         _bg9Scale = ComponentFactory.Instance.creat(bg9ScalseStyle);
         addChild(_bg9Scale);
         var styleArr:Array = contentStyle.split(/,/g);
         contentArr = [];
         for(i = 0; i < styleArr.length; )
         {
            content = ComponentFactory.Instance.creat(styleArr[i]);
            addChild(content);
            contentArr.push(content);
            i++;
         }
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         super.dispose();
         if(_bg9Scale)
         {
            ObjectUtils.disposeObject(_bg9Scale);
         }
         _bg9Scale = null;
         for(i = 0; i < contentArr.length; )
         {
            ObjectUtils.disposeObject(contentArr[i]);
            contentArr[i] = null;
            i++;
         }
         contentArr = null;
      }
   }
}
