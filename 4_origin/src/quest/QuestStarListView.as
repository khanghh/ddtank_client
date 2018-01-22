package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   
   public class QuestStarListView extends Component
   {
       
      
      private var _level:int;
      
      private var _starContainer:HBox;
      
      private var _starImg:Vector.<ScaleFrameImage>;
      
      private var _lightMovie:MovieClip;
      
      public function QuestStarListView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _starContainer = new HBox();
         addChild(_starContainer);
         _starImg = new Vector.<ScaleFrameImage>(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _starImg[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("quest.complete.star");
            _loc1_++;
         }
         _lightMovie = ComponentFactory.Instance.creat("asset.core.improveEffect");
      }
      
      public function level(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         if(param1 > 5 || param1 < 0)
         {
            return;
         }
         _level = param1;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            if(_level > _loc3_)
            {
               if(param2 && _level - 1 == _loc3_)
               {
                  _starContainer.addChild(_lightMovie);
                  _lightMovie.play();
               }
               else
               {
                  _starContainer.addChild(_starImg[_loc3_]);
                  _starImg[_loc3_].setFrame(2);
               }
            }
            else
            {
               _starContainer.addChild(_starImg[_loc3_]);
               _starImg[_loc3_].setFrame(1);
            }
            _loc3_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         if(_starContainer)
         {
            ObjectUtils.disposeObject(_starContainer);
         }
         _starContainer = null;
         if(_lightMovie)
         {
            ObjectUtils.disposeObject(_lightMovie);
         }
         _lightMovie = null;
         if(_starImg)
         {
            _loc1_ = 0;
            while(_loc1_ < 5)
            {
               if(_starImg[_loc1_])
               {
                  ObjectUtils.disposeObject(_starImg[_loc1_]);
               }
               _starImg[_loc1_] = null;
               _loc1_++;
            }
         }
         if(_starImg)
         {
            ObjectUtils.disposeObject(_starImg);
         }
         _starImg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
