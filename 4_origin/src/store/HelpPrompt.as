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
         var _loc3_:int = 0;
         var _loc1_:* = null;
         super.onProppertiesUpdate();
         _bg9Scale = ComponentFactory.Instance.creat(bg9ScalseStyle);
         addChild(_bg9Scale);
         var _loc2_:Array = contentStyle.split(/,/g);
         contentArr = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = ComponentFactory.Instance.creat(_loc2_[_loc3_]);
            addChild(_loc1_);
            contentArr.push(_loc1_);
            _loc3_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         if(_bg9Scale)
         {
            ObjectUtils.disposeObject(_bg9Scale);
         }
         _bg9Scale = null;
         _loc1_ = 0;
         while(_loc1_ < contentArr.length)
         {
            ObjectUtils.disposeObject(contentArr[_loc1_]);
            contentArr[_loc1_] = null;
            _loc1_++;
         }
         contentArr = null;
      }
   }
}
