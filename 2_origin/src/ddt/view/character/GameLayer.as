package ddt.view.character
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   
   public class GameLayer extends BaseLayer
   {
       
      
      private var _state:String = "";
      
      public function GameLayer(info:ItemTemplateInfo, color:String, gunback:Boolean = false, hairType:int = 1, pic:String = null, StateType:String = "")
      {
         _state = StateType;
         super(info,color,gunback,hairType,pic);
      }
      
      override protected function getUrl(layer:int) : String
      {
         return PathManager.solveGoodsPath(_info.CategoryID,_pic,_info.NeedSex == 1,"game",_hairType,String(layer),info.Level,_gunBack,int(_info.Property1),_state);
      }
   }
}
