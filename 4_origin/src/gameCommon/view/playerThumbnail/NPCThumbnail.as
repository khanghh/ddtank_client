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
      
      public function NPCThumbnail(living:Living)
      {
         super();
         _living = living;
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
         var tempIndex:int = 0;
         _name.autoSize = "left";
         _name.wordWrap = false;
         _name.text = _living.name;
         if(_name.width > 65)
         {
            tempIndex = _name.getCharIndexAtPoint(50,5);
            _name.text = _name.text.substring(0,tempIndex) + "...";
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
      
      public function __updateBlood(evt:LivingEvent) : void
      {
         _blood.bloodNum = _living.blood;
      }
      
      public function __die(evt:LivingEvent) : void
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
      
      private function __shineChange(evt:LivingEvent) : void
      {
         var boss:SimpleBoss = _living as SimpleBoss;
      }
      
      protected function overHandler(evt:MouseEvent) : void
      {
         if(lightingFilter)
         {
            this.filters = [lightingFilter];
         }
      }
      
      protected function outHandler(evt:MouseEvent) : void
      {
         this.filters = null;
      }
      
      public function setUpLintingFilter() : void
      {
         var matrix:Array = [];
         matrix = matrix.concat([1,0,0,0,25]);
         matrix = matrix.concat([0,1,0,0,25]);
         matrix = matrix.concat([0,0,1,0,25]);
         matrix = matrix.concat([0,0,0,1,0]);
         lightingFilter = new ColorMatrixFilter(matrix);
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
      
      public function set info(value:Living) : void
      {
         if(!value)
         {
            removeEvents();
         }
         _living = value;
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
