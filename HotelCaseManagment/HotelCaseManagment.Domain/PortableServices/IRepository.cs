using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.Domain.PortableServices
{
   public interface IRepository<TEntity> where TEntity: class
    {
        void Delete(TEntity entity);
        void DeleteAtRange(IEnumerable<TEntity> entity);
        void Insert(TEntity entity);
        void AdAtRange(IEnumerable<TEntity> entity);
        IEnumerable<TEntity> GetAll();
        IEnumerable<TEntity> Find(Expression<Func<TEntity,bool>> expression);
        IEnumerable<TEntity> SingelOrDafault(Expression<Func<TEntity, bool>> expression);
        TEntity FindByID(Guid Id);
       






    }
}
