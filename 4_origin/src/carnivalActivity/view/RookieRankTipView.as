package carnivalActivity.view
{
   import com.pickgliss.ui.core.Component;
   import flash.display.Sprite;
   
   public class RookieRankTipView extends Component
   {
       
      
      private var _tipSp:Sprite;
      
      private var _spWidth:int = 130;
      
      private var _spHeight:int = 31;
      
      public function RookieRankTipView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _tipSp = new Sprite();
         _tipSp.graphics.beginFill(0,0);
         _tipSp.graphics.drawRect(0,0,_spWidth,_spHeight);
         _tipSp.graphics.endFill();
         addChild(_tipSp);
         width = _spWidth;
         height = _spHeight;
      }
      
      override public function dispose() : void
      {
         _tipSp.graphics.clear();
         removeChild(_tipSp);
         _tipSp = null;
         super.dispose();
      }
   }
}
