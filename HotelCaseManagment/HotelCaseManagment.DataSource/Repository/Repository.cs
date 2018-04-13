using HotelCaseManagment.Domain.PortableServices;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace HotelCaseManagment.DataSource.Repository
{
    public class Repository<TEntity> : IRepository<TEntity> where TEntity : class
    {
        protected readonly DbContext Context;
        public Repository( DbContext context)
        {
            Context = context;

        }
        public void AdAtRange(IEnumerable<TEntity> entity)
        {
            Context.Set<TEntity>().AddRange(entity);
        }

        public void Delete(TEntity entity)
        {
            Context.Set<TEntity>().Remove(entity);
        }

        public void DeleteAtRange(IEnumerable<TEntity> entity)
        {
           
            Context.Set<TEntity>().RemoveRange(entity);
        }

        public IEnumerable<TEntity> Find(Expression<Func<TEntity, bool>> expression)
        {
            return Context.Set<TEntity>().Where(expression).ToList();
        }

      //Finns problem med denna method , Problem med assambly filen
        public TEntity FindByID(Guid Id)
        {
           return Context.Set<TEntity>().Find(Id);
        }

        public IEnumerable<TEntity> GetAll()
        {
            return Context.Set<TEntity>().ToList();
        }

        public void Insert(TEntity entity)
        {
           
            Context.Set<TEntity>().Add(entity);
        }

        public IEnumerable<TEntity> SingelOrDafault(Expression<Func<TEntity, bool>> expression)
        {
            return Context.Set<TEntity>().DefaultIfEmpty().Where(expression);
        }
    }
}
