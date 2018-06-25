package oldPlayerRegress.view.itemView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class WelcomeViewItem extends Sprite implements Disposeable
   {
       
      
      private var _title:FilterFrameText;
      
      private var _descript:FilterFrameText;
      
      private var _desOffsetHeight:int;
      
      private var _desOffsetWidth:int;
      
      public function WelcomeViewItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("regress.first");
         _descript = ComponentFactory.Instance.creatComponentByStylename("regress.firstDes");
         addChild(_title);
         addChild(_descript);
      }
      
      public function setData(title:String, descript:String) : void
      {
         _title.htmlText = title;
         _descript.htmlText = descript;
         _descript.x = _desOffsetWidth;
         _descript.y = _title.height + _desOffsetHeight;
      }
      
      public function setDesOffset($width:int = 0, $height:int = 0) : void
      {
         _desOffsetWidth = $width || int(_desOffsetWidth);
         _desOffsetHeight = $height || int(_desOffsetHeight);
         _descript.x = _desOffsetWidth;
         _descript.y = _title.height + _desOffsetHeight;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _title = null;
         _descript = null;
      }
   }
}
