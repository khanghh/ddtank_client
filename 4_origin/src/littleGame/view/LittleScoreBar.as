package littleGame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.PlayerPropertyEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class LittleScoreBar extends Sprite implements Disposeable
   {
       
      
      private var _self:SelfInfo;
      
      private var _back:DisplayObject;
      
      private var _scoreField:GradientText;
      
      public function LittleScoreBar(self:SelfInfo)
      {
         _self = self;
         super();
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.littleGame.ScoreBack");
         addChild(_back);
         _scoreField = ComponentFactory.Instance.creatComponentByStylename("littleGame.ScoreField");
         addChild(_scoreField);
         _scoreField.text = String(_self.Score);
         _scoreField.x = _back.width - _scoreField.width - 6;
      }
      
      private function addEvent() : void
      {
         _self.addEventListener("propertychange",__selfPropertyChanged);
      }
      
      private function removeEvent() : void
      {
         _self.removeEventListener("propertychange",__selfPropertyChanged);
      }
      
      private function __selfPropertyChanged(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Score"])
         {
            _scoreField.text = String(_self.Score);
            _scoreField.x = _back.width - _scoreField.width - 6;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _self = null;
         ObjectUtils.disposeObject(_scoreField);
         _scoreField = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
