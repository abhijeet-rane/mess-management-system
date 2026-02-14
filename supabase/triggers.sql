-- TRIGGER: Auto-create profile in public.users on auth.users insert
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.users (id, full_name, role, photo_url)
  values (
    new.id,
    new.raw_user_meta_data->>'full_name',
    'STUDENT', -- Default role
    new.raw_user_meta_data->>'avatar_url'
  );
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
