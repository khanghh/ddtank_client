package gameCommon.view.playerThumbnail
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.events.LivingEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   import gameCommon.model.Living;
   import gameCommon.model.SimpleBoss;
   
   public class NPCThumbnail extends Sprite implements Disposeable
   {
       
      
      private var _living:Living;
      
      private var _headFigure:HeadFigure;
      
      private var _blood:BloodItem;
      
      private var _name:TextField;
      
      private var _tipContainer:Sprite;
      
      private var lightingFilter:BitmapFilter;
      
      public function NPCThumbnail(param1:Living)
      {
         super();
         _living = param1;
         init();
         initEvents();
      }
      
      public function init() : void
      {
         _headFigure = new HeadFigure(28,28,_living);
         _blood = new BloodItem(_living.blood,_living.maxBlood);
         _name = new TextField();
         initHead();
         initBlood();
         initName();
      }
      
      public function initHead() : void
      {
         _headFigure.x = 7;
         _headFigure.y = 8;
         addChild(_headFigure);
      }
      
      public function initBlood() : void
      {
         _blood.x = 38;
         _blood.y = 26;
         addChild(_blood);
      }
      
      public function initName() : void
      {
         var _loc1_:int = 0;
         _name.autoSize = "left";
         _name.wordWrap = false;
         _name.text = _living.name;
         if(_name.width > 65)
         {
            _loc1_ = _name.getCharIndexAtPoint(50,5);
            _name.text = _name.text.substring(0,_loc1_) + "...";
         }
         _name.mouseEnabled = false;
         addChild(_name);
      }
      
      public function initEvents() : void
      {
         if(_living)
         {
            _living.addEventListener("bloodChanged",__updateBlood);
            _living.addEventListener("die",__die);
            _living.addEventListener("attackingChanged",__shineChange);
            addEventListener("rollOver",overHandler);
            addEventListener("rollOut",outHandler);
         }
      }
      
      public function __updateBlood(param1:LivingEvent) : void
      {
         _blood.bloodNum = _living.blood;
      }
      
      public function __die(param1:LivingEvent) : void
      {
         if(_headFigure)
         {
            _headFigure.gray();
         }
         if(_blood)
         {
            _blood.visible = false;
         }
      }
      
      private function __shineChange(param1:LivingEvent) : void
      {
         var _loc2_:SimpleBoss = _living as SimpleBoss;
      }
      
      protected function overHandler(param1:MouseEvent) : void
      {
         if(lightingFilter)
         {
            this.filters = [lightingFilter];
         }
      }
      
      protected function outHandler(param1:MouseEvent) : void
      {
         this.filters = null;
      }
      
      public function setUpLintingFilter() : void
      {
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat([1,0,0,0,25]);
         _loc1_ = _loc1_.concat([0,1,0,0,25]);
         _loc1_ = _loc1_.concat([0,0,1,0,25]);
         _loc1_ = _loc1_.concat([0,0,0,1,0]);
         lightingFilter = new ColorMatrixFilter(_loc1_);
      }
      
      public function removeEvents() : void
      {
         if(_living)
         {
            _living.removeEventListener("bloodChanged",__updateBlood);
            _living.removeEventListener("die",__die);
            _living.removeEventListener("attackingChanged",__shineChange);
            removeEventListener("rollOver",overHandler);
            removeEventListener("rollOut",outHandler);
         }
      }
      
      public function updateView() : void
      {
         if(!_living)
         {
            this.visible = false;
         }
         else
         {
            if(_headFigure)
            {
               _headFigure.dispose();
               _headFigure = null;
            }
            if(_blood)
            {
               _blood = null;
            }
            init();
         }
      }
      
      public function set info(param1:Living) : void
      {
         if(!param1)
         {
            removeEvents();
         }
         _living = param1;
         updateView();
      }
      
      public function dispose() : void
      {
         if(_tipContainer)
         {
            if(_tipContainer.parent)
            {
               removeChild(_tipContainer);
            }
            _tipContainer = null;
         }
         removeEvents();
         if(parent)
         {
            parent.removeChild(this);
         }
         _headFigure.dispose();
         _headFigure = null;
         _blood.dispose();
         _blood = null;
         _living = null;
      }
   }
}
