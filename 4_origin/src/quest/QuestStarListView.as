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
         var i:int = 0;
         _starContainer = new HBox();
         addChild(_starContainer);
         _starImg = new Vector.<ScaleFrameImage>(5);
         for(i = 0; i < 5; )
         {
            _starImg[i] = ComponentFactory.Instance.creatComponentByStylename("quest.complete.star");
            i++;
         }
         _lightMovie = ComponentFactory.Instance.creat("asset.core.improveEffect");
      }
      
      public function level(value:int, improve:Boolean = false) : void
      {
         var i:int = 0;
         if(value > 5 || value < 0)
         {
            return;
         }
         _level = value;
         for(i = 0; i < 5; )
         {
            if(_level > i)
            {
               if(improve && _level - 1 == i)
               {
                  _starContainer.addChild(_lightMovie);
                  _lightMovie.play();
               }
               else
               {
                  _starContainer.addChild(_starImg[i]);
                  _starImg[i].setFrame(2);
               }
            }
            else
            {
               _starContainer.addChild(_starImg[i]);
               _starImg[i].setFrame(1);
            }
            i++;
         }
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
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
            for(i = 0; i < 5; )
            {
               if(_starImg[i])
               {
                  ObjectUtils.disposeObject(_starImg[i]);
               }
               _starImg[i] = null;
               i++;
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
